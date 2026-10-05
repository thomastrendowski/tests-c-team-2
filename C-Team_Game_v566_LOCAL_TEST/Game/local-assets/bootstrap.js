window.__CT_LOCAL__=true;window.__CT_LOCAL_DATA__={};
(()=>{const resolve=src=>{if(typeof src!=='string'||src.startsWith('data:'))return src;try{const url=new URL(src,location.href),base=new URL('.',location.href);const key=decodeURIComponent(url.pathname.slice(base.pathname.length));return window.__CT_LOCAL_DATA__[key]||src;}catch{return src;}};
window.__CT_LOCAL_RESOLVE__=resolve;
const css=value=>typeof value==='string'?value.replace(/url\(\s*(["']?)(.*?)\1\s*\)/g,(all,quote,url)=>'url("'+resolve(url)+'")'):value;
const setProp=CSSStyleDeclaration.prototype.setProperty;CSSStyleDeclaration.prototype.setProperty=function(name,value,priority){return setProp.call(this,name,css(value),priority);};
for(const property of ['backgroundImage','background']){const desc=Object.getOwnPropertyDescriptor(CSSStyleDeclaration.prototype,property);if(desc?.set)Object.defineProperty(CSSStyleDeclaration.prototype,property,{...desc,set(value){return desc.set.call(this,css(value));}});}
const desc=Object.getOwnPropertyDescriptor(HTMLImageElement.prototype,'src');Object.defineProperty(HTMLImageElement.prototype,'src',{...desc,set(src){return desc.set.call(this,resolve(src));}});
const rawSet=HTMLImageElement.prototype.setAttribute;HTMLImageElement.prototype.setAttribute=function(name,value){return rawSet.call(this,name,String(name).toLowerCase()==='src'?resolve(value):value);};
const fix=im=>{const src=im.getAttribute('src');if(src&&!src.startsWith('data:')){const mapped=resolve(src);if(mapped!==src)im.src=mapped;}};new MutationObserver(records=>{for(const r of records){if(r.type==='attributes'&&r.target.tagName==='IMG')fix(r.target);for(const n of r.addedNodes){if(n.tagName==='IMG')fix(n);n.querySelectorAll?.('img').forEach(fix);}}}).observe(document,{subtree:true,childList:true,attributes:true,attributeFilter:['src']});
const raw=window.fetch;window.fetch=function(src,opt){return raw.call(this,resolve(src),opt);};})();
