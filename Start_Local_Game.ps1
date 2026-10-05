$ErrorActionPreference = 'Stop'
$gameRoot = [IO.Path]::GetFullPath($PSScriptRoot)
$port = 8765
$listener = [Net.Sockets.TcpListener]::new([Net.IPAddress]::Loopback, $port)
try { $listener.Start() } catch { Write-Host 'Close the previous C-Team launcher window and try again. Port 8765 is already in use.'; exit 1 }
Write-Host 'The C-Team is running. Keep this window open while playing. Close it to stop.'
Start-Process "http://127.0.0.1:$port/index.html"
try {
 while ($true) {
  $client = $listener.AcceptTcpClient()
  $stream = $client.GetStream()
  $stream.ReadTimeout = 5000
  $fileStream = $null
  try {
   $reader = [IO.StreamReader]::new($stream, [Text.Encoding]::ASCII, $false, 1024, $true)
   $request = $reader.ReadLine()
   if (-not $request) { continue }
   $parts = $request.Split(' ')
   $headers = @{}
   while ($true) { $line = $reader.ReadLine(); if (-not $line) { break }; $colon = $line.IndexOf(':'); if ($colon -gt 0) { $headers[$line.Substring(0,$colon).ToLowerInvariant()] = $line.Substring($colon+1).Trim() } }
   $relative = [Uri]::UnescapeDataString($parts[1].Split('?')[0]).TrimStart('/')
   if (-not $relative) { $relative = 'index.html' }
   $path = [IO.Path]::GetFullPath([IO.Path]::Combine($gameRoot, $relative.Replace('/',[IO.Path]::DirectorySeparatorChar)))
   if (-not $path.StartsWith($gameRoot + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase) -or -not [IO.File]::Exists($path)) {
    $data = [Text.Encoding]::UTF8.GetBytes('File not found')
    $head = [Text.Encoding]::ASCII.GetBytes("HTTP/1.1 404 Not Found`r`nContent-Length: $($data.Length)`r`nConnection: close`r`n`r`n")
    $stream.Write($head,0,$head.Length); $stream.Write($data,0,$data.Length); continue
   }
   $mime = switch ([IO.Path]::GetExtension($path).ToLowerInvariant()) {
    '.html' {'text/html; charset=utf-8'} '.js' {'application/javascript'} '.json' {'application/json'} '.png' {'image/png'} '.webp' {'image/webp'} '.gif' {'image/gif'} '.jpg' {'image/jpeg'} '.jpeg' {'image/jpeg'} '.mp3' {'audio/mpeg'} '.wav' {'audio/wav'} '.ogg' {'audio/ogg'} '.mp4' {'video/mp4'} default {'application/octet-stream'}
   }
   $fileStream = [IO.File]::OpenRead($path)
   [long]$length = $fileStream.Length; [long]$start = 0; [long]$end = $length-1
   $status = '200 OK'; $rangeHeader = ''
   if ($headers.ContainsKey('range') -and $headers['range'] -match '^bytes=(\d+)-(\d*)$') {
    $start = [long]$Matches[1]
    if ($Matches[2]) { $end = [Math]::Min([long]$Matches[2],$length-1) }
    if ($start -gt $end) { $head = [Text.Encoding]::ASCII.GetBytes("HTTP/1.1 416 Range Not Satisfiable`r`nContent-Range: bytes */$length`r`nContent-Length: 0`r`nConnection: close`r`n`r`n"); $stream.Write($head,0,$head.Length); continue }
    $status = '206 Partial Content'; $rangeHeader = "Content-Range: bytes $start-$end/$length`r`n"
   }
   [long]$remaining = $end-$start+1
   $head = [Text.Encoding]::ASCII.GetBytes("HTTP/1.1 $status`r`nContent-Type: $mime`r`nContent-Length: $remaining`r`nAccept-Ranges: bytes`r`n${rangeHeader}Cache-Control: no-cache`r`nConnection: close`r`n`r`n")
   $stream.Write($head,0,$head.Length)
   if ($parts[0] -ne 'HEAD') {
    $fileStream.Position = $start
    $buffer = New-Object byte[] 65536
    while ($remaining -gt 0) { $count = $fileStream.Read($buffer,0,[int][Math]::Min($buffer.Length,$remaining)); if ($count -le 0) { break }; $stream.Write($buffer,0,$count); $remaining -= $count }
   }
  } catch { } finally { if ($fileStream) { $fileStream.Dispose() }; $stream.Dispose(); $client.Close() }
 }
} finally { $listener.Stop() }
