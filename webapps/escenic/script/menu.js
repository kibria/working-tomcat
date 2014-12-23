/* Add menu functionality such as on-click handlers and mouse-out events to menu. */
/* Menu looks like what is in menu.html


*/


/* basic algorithm:

 A global keeps track of what menu is currently expanded
 Whenever a menu is deemed to expand, the currently expanded menu is collapsed first
 To expand a menu, the global is updated, and the class of the corresponding item is
  morphed to 'expanded'
 A setTimeout handler is also set to hide the menu after a few seconds.

 On load, add handlers for:

   (1) add on-click handlers to all expandable menu items  (i.e. class expandable)
   (2) add on-mouse-over handlers to all expandable things
   (3) add on-mouse-out handlers for ditto


 */




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




var menuTimeoutId = false;
var menuLastExpandedNode = false;


function collapseMenu() {
  if (menuLastExpandedNode) {
    morphclass(document.getElementById(menuLastExpandedNode),'expanded','collapsed');
    menuLastExpandedNode = false;
    clearMenuTimeout();
  }
}

function expandMenu(nodeId) {
  collapseMenu();
  var node = document.getElementById(nodeId);
  if (node) {
    menuLastExpandedNode = nodeId;
    morphclass(node, 'collapsed', 'expanded');
    collapseInDueTime(nodeId);
  }
}

function clearMenuTimeout() {
  if (menuTimeoutId) {
    clearTimeout(menuTimeoutId);
    menuTimeoutId = false;
  }
}

function keepExpandedMenu() {
  clearMenuTimeout();
}

function collapseInDueTime(nodeId) {
  menuTimeoutId = setTimeout('collapseMenu()', 3000);
}

