/**
 * RuzeeBorders Version 0.7.1
 * (c) 2006 Steffen Rusitschka, www.ruzee.com, All Rights Reserved.
 *
 * You may use this software free of charge. You may modify and 
 * redistribute it as long as this complete comment remains included.
 * There is no warranty of any kind. Contact steffen@rusitschka.de for
 * details on its commercial usage.
 */
function rzCrSimpleBorder(rad){
  return new RuzeeBorder(rad,rad,rad,0,true,'000');
}

function rzCrShadowBorder(rad,smar,coShadowS){
  return new RuzeeBorder(rad,rad+smar*2,rad+smar,Math.round(smar/2),false,coShadowS);
}

function rzCrFadeBorder(rad){
  return new RuzeeBorder(1,rad,1,0,true,'.fade');
}

function rzCrGlowBorder(rad,gmar,coGlowS){
  return new RuzeeBorder(rad,rad+gmar,rad,0,true,coGlowS);
}

function RuzeeBorder(cr,sr,sp,ss,si,cs){

this.isIE=navigator.userAgent.toLowerCase().indexOf('msie') > 0
  && navigator.userAgent.toLowerCase().indexOf('opera') == -1;
this.isXHTML=/html\:/.test(document.getElementsByTagName('body')[0].nodeName);
this.isStrict=document.compatMode?document.compatMode!='BackCompat':false;
this.cornerRadius=cr?cr:6;
this.shadowRadius=sr?sr:18;
this.shadowPadding=sp?sp:14;
this.shadowShift=ss?ss:0;
this.simple=si?si:false;
this.coShadowS=cs?cs:'000';

this.crDiv=function(w,h,bg,o){
  var d=this.isXHTML
    ?document.createElementNS('http://www.w3.org/1999/xhtml','div')
    :document.createElement('div');
  d.style.padding=d.style.margin='0px';
  d.style.display='block';
  d.style.border='none';
  d.style.width=w?w:'auto';
  if(h) { d.style.height=h; d.style.fontSize=h; }
  if(!bg) bg='transparent';
  d.style.background=bg;
  if(o) d.style.overflow=o;
  return d;
}

this.addLRD=function(c,l,r,bg,fst){
  var w=this.crDiv(null,null,bg);
  this.flt(l,'left');
  this.flt(r,'right');
  l.style.overflow=r.style.overflow='hidden';
  if(this.isIE&&fst){ // fix IE 3px bug
    l.style.marginRight=r.style.marginLeft='-3px';
  }
  if(this.isL){
    c.style.marginLeft=l.style.width;
    w.appendChild(l);
  }
  if(this.isR){
    c.style.marginRight=r.style.width;
    w.appendChild(r);
  }
  w.appendChild(c);
  return w;
}

this.addLRC=function(c,co,w,h){
  var e=this.crDiv(null,h,co);
  if(!w) w='1px';
  c.style.margin='0px '+(this.isR?w:'0px')+' 0px '+(this.isL?w:'0px');
  e.appendChild(c);
  return e;
}

this.flt=function(e,f){
  e.style.cssFloat=e.style.styleFloat=f;
}

this.crTB=function(top){
  var sh=top?-this.shadowShift:this.shadowShift;
  var cxc=this.shadowPadding-this.cornerRadius-1;
  var cxb=cxc;
  var cxe=cxc+this.cornerRadius;
  var exb=0;
  var exe=cxc-1;
  var syc=this.cornerRadius-this.shadowPadding+sh+1;
  var yb,ye;
  if(top){
    yb=syc+this.shadowRadius-1; 
    // to cut it
    if(!this.simple&&yb<this.cornerRadius){
      yb=this.cornerRadius;
    }
    ye=-1;
    yi=-1;
    this.psT=yb+1;
  }else{
    if(!this.isB) {
      this.psB=0;
      return;
    }
    yb=syc<0?syc:0;
    ye=syc+this.shadowRadius;
    yi=1;
    this.psB=ye-yb;
  }

  var e=this.crDiv(null, Math.abs(yb-ye)+'px');
  for(var y=yb; y!=ye; y+=yi){
    var co;
    if(y<=this.cornerRadius-this.wBorder){
      co=this.coBgIn;
    }else if(y<=this.cornerRadius){
      co=this.coBorder;
    }else if(y-syc<0){
      co=this.coShadow;
    }else{
      co=rzBlend(this.coShadow,this.coBgOut,(y-syc)/this.shadowRadius);
    }
    var line=this.crDiv(null,'1px',rzC2S(co),'hidden');
    for(var x=0; x<this.shadowRadius; ++x){
      var sd, out=0;
      if(y<syc){
        sd=x;
      }else{
        sd=Math.sqrt(Math.sqr(x)+Math.sqr(y-syc));
      }
      if(this.shadowRadius>this.cornerRadius && sd<=this.shadowRadius){
        co=rzBlend(this.coShadow, this.coBgOut, sd/this.shadowRadius);
      }else{
        co=this.coBgOut;
        out++;
      }
      if(y<=this.cornerRadius){
        if(x>=exb && x<=exe){
          co=y>this.cornerRadius-this.wBorder?this.coBorder:this.coBgIn;
        }else if(x>=cxb && x<=cxe){
          var cd=Math.sqrt(Math.sqr(x-cxc)+Math.sqr(y))-this.cornerRadius;
          if(y<0){
            co=x-cxc>this.cornerRadius-this.wBorder?this.coBorder:this.coBgIn;
          }else if(cd<-this.wBorder){
            co=this.coBgIn;
          }else if(cd<-this.wBorder+1){
            co=rzBlend(this.coBgIn,this.coBorder,cd+this.wBorder);
          }else if(cd<0){
            co=this.coBorder;
/*          }else if(cd<0){
            co=rzBlend(this.coBorder,this.coBgIn,-cd);*/
          }else if(cd<=1){
            co=rzBlend(this.coBorder,co,cd);
          }else{
            out++;
          }
/*          if(y<0 || cd<-1){
            co=x==cxe?this.coBorder:this.coBgIn;
          }else if(cd<0){
            co=rzBlend(this.coBorder,this.coBgIn,-cd);
          }else if(cd<=1){
            co=rzBlend(this.coBorder,co,cd);
          }else{
            out++;
          }*/
        }
      }else{
        out++;
      }
      if(out>1){
        line=this.addLRC(line,'transparent',(this.shadowRadius-x)+'px');
        x=this.shadowRadius; // done
      }else{
        line=this.addLRC(line,rzC2S(co));
      }
    }
    e.appendChild(line);
  }
  return e;
}

this.crLR=function(e){
  var coBgInS=rzC2S(this.coBgIn);
  var coBS=rzC2S(this.coBorder);
  e=this.addLRC(e,coBgInS,'3px');
  if(this.wBorder>0) e=this.addLRC(e,coBS,this.wBorder+'px');
  var ye=this.shadowPadding+this.shadowShift-this.cornerRadius-2;
  for(var x=this.shadowPadding; x<this.shadowRadius; ++x){
    var l=this.crDiv('1px');
    var r=this.crDiv('1px');
    var coS;
    for(var y=ye; y>0; --y){
      var d=Math.sqrt(Math.sqr(x)+Math.sqr(y));
      if (this.shadowRadius<=this.cornerRadius || d>this.shadowRadius){
        coS=rzC2S(this.coBgOut);
      }else{
        coS=rzC2S(rzBlend(this.coShadow,this.coBgOut,d/this.shadowRadius));
      }
      l.appendChild(this.crDiv('1px','1px',coS,'hidden'));
      r.appendChild(this.crDiv('1px','1px',coS,'hidden'));
    }
    coS=rzC2S(rzBlend(this.coShadow,this.coBgOut,x/this.shadowRadius));
    if(ye<=0){
      l.appendChild(this.crDiv('1px','1px',coS,'hidden'));
      r.appendChild(this.crDiv('1px','1px',coS,'hidden'));
    }
    e=this.addLRD(e,l,r,coS);
  }
  return e;
}

this.crLRC=function(e){
  var coBgInS=rzC2S(this.coBgIn);
  var coBS=rzC2S(this.coBorder);
  e=this.addLRC(e,coBgInS,'3px');
  if(this.wBorder>0) e=this.addLRC(e,coBS,this.wBorder+'px');
  for(var x=this.shadowPadding; x<this.shadowRadius; ++x){
    coS=rzC2S(rzBlend(this.coShadow,this.coBgOut,x/this.shadowRadius));
    e=this.addLRC(e,coS);
  }
  return e;
}

this.setPad=function(d,s,l,subPx){
  padL='padding-'+l;
  borL='border-'+l+'-width';
  var pad=rzGetStyle(s,padL);
  var bor=rzGetStyle(s,borL);
  
  var v=rzPX2I(pad)+rzPX2I(bor)-subPx;
  d.style[rzCC(padL)]=(v<0?0:v)+'px';
}

this.draw=function(e,edges){
  if(e && (typeof e=='string')) {
    if(e.charAt(0)=='.'){
      e=rzGetElementsByClass(e.substr(1));
    }else{
      e=document.getElementById(e);
    }
  }
  if(!e) return;
  if(e.constructor==Array){
    for(var i=0; i<e.length; ++i){
      this.draw(e[i],edges);
    }
    return;
  }
  var ed='lrtb';
  if(edges) ed=edges.toLowerCase();
  this.isL=ed.indexOf('l')>=0;
  this.isR=ed.indexOf('r')>=0;
  this.isT=ed.indexOf('t')>=0;
  this.isB=ed.indexOf('b')>=0;

  // This will throw an exception in Konqueror...
//   this.imgBgIn=rzGetStyle(e,'background-image');
  this.coBgIn=rzS2C(rzGetStyle(e,'background-color'));
  this.coBgOut=rzS2C(rzGetStyle(e.parentNode,'background-color'),'#ffffff');
  var borderCSS='border-'+(this.isT?'top-':'bottom-');
  var bs=rzGetStyle(e,borderCSS+'style',false,'none');
  if(bs && bs!='' && bs!='none' && bs!='hidden'){
    this.coBorder=rzS2C(rzGetStyle(e,borderCSS+'color',false,'black'));
    this.wBorder=rzPX2I(rzGetStyle(e,borderCSS+'width',false,'1px'));
  }else{
    this.coBorder=this.coBgIn;
    this.wBorder=1;
  }
  this.coShadow=this.coShadowS=='.fade'?this.coBorder:rzS2C(this.coShadowS);
  var wr=this.crDiv();
  var cwr=this.crDiv(null,null,rzC2S(this.coBgIn),'hidden');

  this.psT=0;
  this.psB=0;
  if(this.isT) wr.appendChild(this.crTB(true));
  wr.appendChild(this.simple||!this.isT?this.crLRC(cwr):this.crLR(cwr));
  if(this.isB) wr.appendChild(this.crTB(false));

  var psLR=this.shadowRadius-this.shadowPadding+3+this.wBorder;
  if(this.isIE && !this.simple && this.isT) psLR+=3;
  var psL=this.isL?psLR:0;
  var psR=this.isR?psLR:0;
  this.setPad(cwr,e,'top',(this.psT+this.psB)/2); 
  this.setPad(cwr,e,'bottom',(this.psT+this.psB-1)/2); // -1 for rounding
  this.setPad(cwr,e,'left',psL);
  this.setPad(cwr,e,'right',psR);

  if(this.isIE) e.style.height=cwr.style.height='1%'; // fix IE 3px jog when floated
  e.style.padding='0px';
  e.style.border='none';
  e.style.background='transparent';
  e.appendChild(wr);
  while (e.childNodes.length>1){
    cwr.appendChild(e.removeChild(e.childNodes[0]));
  }
}
} // of RuzeeBorder

// internal tools

Math.sqr=function(x){
  return x*x;
}

function rzCC(s){
  for(var exp=/-([a-z])/; exp.test(s); s=s.replace(exp,RegExp.$1.toUpperCase()));
  return s;
}

function rzGetStyle(e,a,transOk,d){
  if(e==null) return d;
  if(typeof e=='string') e=document.getElementById(e);
  var v;
  if(document.defaultView){
    var cs=document.defaultView.getComputedStyle(e,null);
    if (!cs && window.getComputedStyle) cs=window.getComputedStyle(e,null);
    if(cs){
      v=cs.getPropertyValue(a);
      if(!v && cs.getPropertyCSSValue){
        v=cs.getPropertyCSSValue(a);
        if(v) v=v.getStringValue();
      }
    }
  }

  if(!v && e.currentStyle){
    v=e.currentStyle[rzCC(a)];
    if (!v) v=e.currentStyle[a];
  }

  if(!v) v=e.style[rzCC(a)];
  // KHTML bug fix: transparent is #000000 - if you want black, use #010101 in your CSS.
  // Safari work around: transparent is 'rgba(0, 0, 0, 0)'
  if(!transOk && v && (v.toLowerCase()=='transparent' || v=='#000000' || v=='rgba(0, 0, 0, 0)')) v=null;
  return v?v:d?d:rzGetStyle(e.parentNode,a);
}

function rzGetElementsByClass(c,n,t) {
  var a=new Array();
  if (!n) n=document;
  if (!t) t='*';
  var l=n.getElementsByTagName(t);
  var pattern=new RegExp('(^|\\s)'+c+'(\\s|$)');
  for (i=0; i<l.length; i++){
    if (pattern.test(l[i].className)){
      a.push(l[i]);
    }
  }
  return a;
}

function rzPX2I(px){
  if(!px) return 0;
  var p=/\s*(\d\d*)px/.exec(px);
  if(p) return parseInt(p[1]);
  return 0;
}

function rzS2C(s,d){
    if (!s) return d?rzS2C(d):[0,0,0,0];
    if (s.charAt(0)=='#') s=s.substr(1,6);
    s=s.replace(/ /g,'').toLowerCase();
    // The CSS 2.1 colors
    var COLORS = {
         aqua:'00ffff', black:'000000', blue:'0000ff', fuchsia:'ff00ff',
         gray:'808080', green:'008000', lime:'00ff00', maroon:'800000',
         navy:'000080', olive:'808000', orange:'ffa500', purple:'800080',
         red:'ff0000', silver:'c0c0c0', teal:'008080', white:'ffffff',
         yellow:'ffff00'
    };
    for (var key in COLORS) if (s==key) s=COLORS[key];

    var p=/^rgba\((\d{1,3}),\s*(\d{1,3}),\s*(\d{1,3}),\s*(\d{1,3})\)$/.exec(s);
    if(p) return [parseInt(p[1]),parseInt(p[2]),parseInt(p[3]),parseInt(p[4])];
    var p=/^rgb\((\d{1,3}),\s*(\d{1,3}),\s*(\d{1,3})\)$/.exec(s);
    if(p) return [parseInt(p[1]),parseInt(p[2]),parseInt(p[3]),255];
    p=/^(\w{2})(\w{2})(\w{2})$/.exec(s);
    if(p) return [parseInt(p[1],16),parseInt(p[2],16),parseInt(p[3],16),255];
    p=/^(\w{1})(\w{1})(\w{1})$/.exec(s);
    if(p) return [parseInt(p[1]+p[1],16),parseInt(p[2]+p[2],16),parseInt(p[3]+p[3],16),255];
    return d?rzS2C(d):[0,0,0,0];
}

function rzC2S(c){
  if(typeof c=='string') return c;
  r='0'+c[0].toString(16);
  g='0'+c[1].toString(16);
  b='0'+c[2].toString(16);
  return '#'
    +r.substring(r.length-2)
    +g.substring(g.length-2)
    +b.substring(b.length-2);
}

function rzBlend(a,b,w){
  return Array(
    Math.round(a[0]+(b[0]-a[0])*w),
    Math.round(a[1]+(b[1]-a[1])*w),
    Math.round(a[2]+(b[2]-a[2])*w),
    Math.round(a[3]+(b[3]-a[3])*w));
}
