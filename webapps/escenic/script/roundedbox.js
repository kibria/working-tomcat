function roundedCorners() {
  fixOutputBoxContent();
  wrapElements('div','roundedbox','div','roundedbox-bordermargin','div');
  wrapElements('input','important-button','span','importantbutton-bordermargin');
  return true;
}

function wrapElements(elementname, classname, newelementname, newclassname, linebreakname) {
 var divs = document.getElementsByTagName(elementname);
 var rounded_divs = [];
 /* First locate all elements with the specified class */
 var re = new RegExp('\\b' + classname + '\\b')
 for (var i = 0; i < divs.length; i++) {
   if (re.exec(divs[i].className)) {
     rounded_divs[rounded_divs.length] = divs[i];
   }
 }
 /* Now add additional divs to each of the divs we have found */
 for (var i = 0; i < rounded_divs.length; i++) {
   var original = rounded_divs[i];

   morphclass(original,classname, '');
   /* Now create the outer-most div */
   var box = document.createElement(newelementname);
   var bg = document.createElement(newelementname);
   var tl = document.createElement(newelementname);
   var tr = document.createElement(newelementname);
   var bl = document.createElement(newelementname);
   var br = document.createElement(newelementname);

   box.className = newclassname + '-box';
   bg.className = newclassname + '-bg';
   tl.className = newclassname + '-tl';
   tr.className = newclassname + '-tr';
   bl.className = newclassname + '-bl';
   br.className = newclassname + '-br';

   box.appendChild(bg);
   bg.appendChild(tl);
   tl.appendChild(tr);
   tr.appendChild(bl);
   bl.appendChild(br);

   /* Swap out the original (we'll put it back later) */
   original.parentNode.replaceChild(box, original);
   br.appendChild(original);
   /* linebreaks must be added since IE6 incorrectly renders bg's background
    * even in the box' padding...  *nnngh*
    */
   if (linebreakname) {
     var linebreak = document.createElement(linebreakname);
     linebreak.appendChild(document.createTextNode("\u00a0"));
     linebreak.className="linebreak";
     box.appendChild(linebreak);
   }
 }
}
/* Run the function once the page has loaded: */

registerHook('onLoad', roundedCorners);

  /*
   * Toggles a class within the given element's 'className'
   * from style1 to style2 and vice versa.
   * e.g.:  From 'foo' to 'bar':
   *   class='foo' becomes class='bar'
   *   class='bar' becomes class='foo' (like a toggle...)
   *   class='foobar' becomes class='foobar'
   *   class='foo baz' becomes class='bar baz'
   *   class='foobar foobaz foo' becomes class='foobar foobaz bar'
   */
  function toggleclass(element, style1, style2) {
    if (element) {
      // add whitespace before and after current style
      oldstyle = ' ' + element.className + ' ';
      newstyle = oldstyle.replace(" " + style1 + " ", " " + style2 + " ");
      if (oldstyle != newstyle) {
        // remove tacked on whitespace.
        newstyle = newstyle.substring(1);
        newstyle = newstyle.substring(0,newstyle.length-1);
        element.className = newstyle;
      } else {
        newstyle = oldstyle.replace(" " + style2 + " ", " " + style1 + " ");
        if (oldstyle != newstyle) {
          // remove tacked on whitespace.
          newstyle = newstyle.substring(1);
          newstyle = newstyle.substring(0,newstyle.length-1);
          element.className = newstyle;
        }
      }
    }
  }

  /*
   * Morphs a class within the given element's 'className'
   * from style1 to style2 (does not toggle!).
   * e.g.:  From 'foo' to 'bar':
   *   class='foo' becomes class='bar'
   *   class='bar' becomes class='bar'
   *   class='foobar' becomes class='foobar'
   *   class='foo baz' becomes class='bar baz'
   *   class='foobar foobaz foo' becomes class='foobar foobaz bar'
   */
  function morphclass(element, style1, style2) {
    if (element) {
      // add whitespace before and after current style
      oldstyle = ' ' + element.className + ' ';
      newstyle = oldstyle.replace(" " + style1 + " ", " " + style2 + " ");
      if (oldstyle != newstyle) {
        // remove tacked on whitespace.
        newstyle = newstyle.substring(1);
        newstyle = newstyle.substring(0,newstyle.length-1);
        element.className = newstyle;
      }
    }
  }

  /* find all 'div class=content' with an enclosing 'div class=output-box' and add a 'roundedbox' css style.  */
  function fixOutputBoxContent() {
    var elemColl = getElementsWithClassName('div','content');
    for (var i = 0; i< elemColl.length; i++) {
      if (hasClass(elemColl[i].parentNode,'output-box')) {
        elemColl[i].className += ' roundedbox';
      }
    }
  }



function hasClass(object, className) {
  if (!object) return false;
  if (!object.className) return false;
  return (object.className.search('(^|\\s)' + className + '(\\s|$)') != -1);
}

function getElementsWithClassName(elementName, className) {
  var allElements = document.getElementsByTagName(elementName);
  var elemColl = new Array();
  for (var i = 0; i< allElements.length; i++) {
    if (hasClass(allElements[i], className)) {
      elemColl[elemColl.length] = allElements[i];
    }
  }
  return elemColl;
}


function fixInputClasses() {
  var allElements = document.getElementsByTagName('input');
  for (var i = 0; i< allElements.length; i++) {
    if (! allElements[i].type) {
      // ignore elements w/o type...
      continue;
    }

    if (allElements[i].type == 'text') {
      allElements[i].className += " input-text";
      continue;
    }

    if (allElements[i].type == 'password') {
      allElements[i].className += " input-password";
      continue;
    }

    if (allElements[i].type == 'button') {
      allElements[i].className += " input-button";
      continue;
    }

    if (allElements[i].type == 'radio') {
      allElements[i].className += " input-radio";
      continue;
    }

    if (allElements[i].type == 'checkbox') {
      allElements[i].className += " input-checkbox";
      continue;
    }
  }
  return true;
}


registerHook('onLoad', fixInputClasses);


function alertErrorsByType(type) {
  var allElements = document.getElementsByTagName(type);  
  var displayedMessages = '';
  for (var i = 0; i < allElements.length; i++) {
    var message;
    if (allElements[i].className && allElements[i].className == 'error') {
      if (allElements[i].innerText && allElements[i].innerText.match(/[a-zA-Z]/)) {
        message = allElements[i].innerText;
      }else if (allElements[i].textContent && allElements[i].textContent.match(/[a-zA-Z]/)) {
        message= allElements[i].textContent;
      }else{
        continue;
      }
      if(displayedMessages.indexOf(message)>=0){
        //already displayed. do nothing
      }else{
        alert(message);
        displayedMessages = displayedMessages + ' ' + message;
      }
    }
  }
  return true;
}

function moveNavigationMenu() {
  var navmenu = document.getElementById('navigationmenu');
  var maincontentnav = document.getElementById('main-content-nav');
  if (! navmenu) return true;
  if (! maincontentnav) return true;
  if (! navmenu.parentNode) return true;
  if (! maincontentnav.appendChild) return true;
  navmenu.parentNode.removeChild(navmenu);
  maincontentnav.appendChild(navmenu);
  return true;
}

registerHook('onLoad', moveNavigationMenu);


function alertErrors() {
  alertErrorsByType('span');
  return true;
}

registerHook('onLoad', alertErrors);



function openPreviewWindowHook() {
  window.open('','escenicPreview').focus();
}

function fixOpenPreview() {
  var allElements = document.getElementsByTagName('a');
  for (var i = 0; i < allElements.length; i++) {
    if (allElements[i].target && allElements[i].target == 'escenicPreview') {
      allElements[i].onclick = openPreviewWindowHook;
    }
  }
  return true;
}

registerHook('onLoad',fixOpenPreview);