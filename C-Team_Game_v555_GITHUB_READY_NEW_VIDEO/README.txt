THE C-TEAM v554 — GAMEPLAY AND PROGRESSION

1. Extract the ENTIRE ZIP before playing.
2. Open Start_Game.html. Keep Game/ and Media/ together in this folder.
3. Existing v553 production saves are retained. Without a production save,
   this version starts fresh. It resets only
   The C-Team's prior completion, unlock, reward, and score records in that
   browser origin. Subsequent openings retain progress. Browser saves are
   specific to the browser/profile and location where you open the game.

FIRST-TIME SETUP
The introduction video plays, then Extra Credit Gone Wrong gives the story
context, then Pick 6 begins. If autoplay with sound is blocked,
click Start video. Skip introduction is available as a smaller button.
Choose exactly six favorites and click Continue. Picks save permanently;
unfinished picks are saved so setup can resume after closing the game.
Awesomeo, Miss Piggy, Li'l Sebastian, and Randall are automatic starters.
Their cards say Available from Start and do not consume one of the six picks.
Other playable characters unlock after beating the level where they are
bosses, in either Content Review or Play Without Questions.

PROGRESSION
Start with level 1. Beat each level to unlock the next. Boss characters and
that board's Morph-Up become permanently available after the win.
The six starting Morph-Ups are Duffman, Green Goblin, Grinch + Max,
Leeroy Jenkins, Snoopy + Woodstock, and T-101.
All 16 question sets are retained. Each question-mode level uses the full
selected question set: one flamingo per question, with the matching HUD and
exit requirement. UDL has 12 flamingos. Free Play retains 15 flamingos.
The question queue starts fresh for each level run.

STORIES AND VIDEO
The supplied 24 storyboard images display before the first entry into each
board. Continue starts gameplay. Storyboards on the main menu opens the
complete gallery, including the introductory story. Replay introduction
replays the video followed by the introductory story on demand.
After beating level 24, the same video plays again; Pick 6 does not repeat.

REPLACE MEDIA
Intro: Media/Intro_Video/intro.mp4
Stories: Media/Storyboards/<level-key>/storyboard.png
Replace the existing files using those EXACT filenames. PNG image files
should remain PNG; do not merely rename a JPEG extension to PNG.
The original supplied scripts are preserved as story.md beside each image.
Media/media_manifest.json lists the level-key mapping in game order.
Media files remain external to the HTML so you can replace them later.
Refresh/reopen the game after replacing an asset.

VALIDATION
See Reference/Verification_v554.json for the new combat and opening-story
checks, and Verification_v553.json for the earlier progression checks.
Wins in automated checks use simulated completed encounters; this does
not constitute a manual playthrough of all 24 levels or every character.

COMBAT REPAIRS v554
Removed the obsolete automatic Clayface pickups in Gotham. T-101 uses his
shooting frames and travelling lasers. Shredder hits only within the visible
beam after it reaches the enemy. Respawning runners rejoin F collision checks.
Existing v553 favorites and progression are retained.

INTRODUCTORY STORY
Replace Media/Storyboards/introduction/storyboard.png to update the opening
comic. Its supplied artwork and lettering are preserved. An unfinished new
save resumes this story before Pick 6. Existing completed saves are retained.
