/*
 * Copyright (C) 2002 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be
 * included on all copies, modifications and derivatives of this
 * work.
 */

var bV=parseInt(navigator.appVersion);
var NS4=(document.layers) ? true : false;
var IE4=((document.all)&&(bV>=4))?true:false;
var ver4 = (NS4 || IE4) ? true : false;
var NS6 = true;
var debug = false;
var info = false;

/*
  Hooks.  Use these to customize
 */

  var updateGroupOnScreenHook = new Function("return;");
  var setMetaDataForSlotHook = new Function("return;");
  var setMetaDataForItemHook = new Function("return;");
  var getMetaDataForItemHook = new Function("return;");

/* Simple browser independency methods... */
  function IE4_getRealLeft(imgElem) {
	xPos =  imgElem.offsetLeft;
	tempEl = imgElem.offsetParent;
  	while (tempEl != null) {
  		xPos += tempEl.offsetLeft;
  		tempEl = tempEl.offsetParent;
  	}
	return xPos;
  }

  function IE4_getRealTop(imgElem) {
	yPos = imgElem.offsetTop;
	tempEl = imgElem.offsetParent;
	while (tempEl != null) {
  		yPos += tempEl.offsetTop;
  		tempEl = tempEl.offsetParent;
  	}
	return yPos;
  }






var __groups = new Array();
var __groupsByName = new Array();
var __slots  = new Array();
var __slotsByName  = new Array();
var __itemsByName  = new Array();
var __itemsByIndex = new Array();
var __selection = new Array();
var __selectionCount = 0;
var __transaction = null;



// Basic functions that can access the "private" __ variables.
function setupGroup(groupName, visibility, firstIndex, lastIndex) {
  __groups[__groups.length] = new Array();
  var g = __groups[__groups.length -1];
  g.visibility = visibility;
  g.index = __groups.length -1;
  g.firstSlotIndex = firstIndex;
  g.lastSlotIndex = lastIndex;
  g.nextSlotIndex = firstIndex;
  g.name = groupName;
  g.type = 'group';
  g.elements = new Array();
  __groupsByName[g.name] = g;
}

function setupSlot(groupName, slotName) {
  var g = getGroupByName(groupName);
  var i = g.nextSlotIndex;
  if (i > g.lastSlotIndex) error('Group ' + groupName + ' was set up with too many slots! (' + slotName + ')');
  __slots[i] = new Array();
  s = __slots[i];
  g.nextSlotIndex++;
  s.name = slotName;
  s.group = g;
  if (NS4) {
    if (document.images['slot_' + slotName]) s.visibility = 'visible';
    else s.visibility = 'hidden';
  } else {
    if (document.getElementById('slot_' + slotName)) s.visibility = 'visible';
    else s.visibility = 'hidden';
  }
  s.contents = null;
  s.type = 'slot'
  s.index = i;
  s.elementIndex = -3;
  __slotsByName[s.name] = s;
  if (debug) alert("set up new slot: " + i + " called " + s.name);
  return s;
}

// initially set up the item in the named slot.  Also
// ensure that the item is physically moved to its position.
function setupItem(itemName, slotName, active) {
  // if there was no item name, this is a "nop".
  if (itemName == '') return;
  if (!existsMovableItemCalled(itemName)) {
    error("There was no DIV tag named '" + itemName + "'; the item was to be put into " + slotName + ".");
    return;
  }
  if (slotName != null) {
    if (!getSlotByName(slotName)) {
      error("There was no slot set up named " + slotName + "; item "+ itemName + " has no place to go...");
      return;
    }
  }

  __itemsByName[itemName] = new Array();
  __itemsByName[itemName].name = itemName;
  __itemsByName[itemName].fixed = existsFixedItemCalled(itemName);
  __itemsByName[itemName].type = 'item';
  __itemsByName[itemName].meta = new Array();
  __itemsByName[itemName].active = active
  __itemsByName[itemName].meta.articleId = itemName;  // this will stick with the item for ever...
  __itemsByIndex[__itemsByIndex.length] = __itemsByName[itemName];


  if (slotName != null) {
    moveItemToSlot(__itemsByName[itemName], getSlotByName(slotName));
  }
  setMetaDataForItem(__itemsByName[itemName], __itemsByName[itemName].meta)
  if (slotName != null) {
    setMetaDataForSlot(findSlotWithItem(__itemsByName[itemName]));
  }
}

function setupElement(groupName, elementName) {
  var g = getGroupByName(groupName);
  var e = new Array();
  g.elements[g.elements.length] = e;
  e.name = elementName;
  return e;
}

function getSlotCount() {
  return __slots.length;
}

function getGroupCount() {
  return __groups.length;
}

function getSelectionCount() {
  return __selectionCount;
}


function getGroupByName(groupName) {
  return __groupsByName[groupName];
}

function getGroupByIndex(index) {
  return __groups[index];
}

function getSlotByName(slotName) {
  if (debug) alert ('slot ' + slotName);
  if (!__slotsByName[slotName]) alert(getSlotByName.caller +' asked for invalid slot ' + slotName)
  return __slotsByName[slotName];
}

function getSlotByIndex(index) {
  return __slots[index];
}

function getSlotAfter(slot) {
  if (slot.index == slot.group.lastSlotIndex) return null;
  return __slots[slot.index + 1];
}

function getSlotBefore(slot) {
  if (slot.index == slot.group.firstSlotIndex) return null;
  return __slots[slot.index - 1];
}

function getItemByName(name) {
  return __itemsByName[name];
}

function getItemByIndex(index) {
//   alert(index + ", " + __itemsByIndex.length);
  return __itemsByIndex[index];
}

function getItemCount() {
  return __itemsByIndex.length;
}

/*
 * Return the index of the item in the selection array, if 
 * this item is selected.
 */
function getSelectionIndexOfItem(item) {
  if (item == null) {
    alert(getSelectionIndexOfItem.caller + " tried to get selection index of null item...");
    return -1;
  }
  for (var i = 0; i < __selection.length; i++) {
    if (__selection[i] == item.name) {
      return i;
    }
  }
  return -1;
}

function isItemSelected(item) {
  if (item == null) {
    alert(isItemSelected.caller + " tried to get selection index of null item...");
    return false;
  }
  return getSelectionIndexOfItem(item) != -1;
}

function selectItemInModel(item) {
  __selectionCount++;
  for (var i = 0; i < __selection.length; i++) {
    if (__selection[i] == null) {
      __selection[i] = item.name;
      return;
    }
  }
  __selection[__selection.length] = item.name;
}

function deselectItemInModel(item) {
  var i = getSelectionIndexOfItem(item);
  if (i != -1) {
    __selection[i] = null;
    __selectionCount--;
  }
}

function clearSelection() {
  var wasInTx = isInTransaction();
  if (!wasInTx) startTransaction();
  for (var i = 0; i < __selection.length; i++) {
    if (__selection[i] != null) {
      addObjectToTransaction(getItemByName(__selection[i]));
      addObjectToTransaction(findSlotWithItem(getItemByName(__selection[i])));
      __selection[i] = null;
      __selectionCount--;
    }
  }
  if (__selectionCount != 0) {
    alert('after clearing selections there are ' + __selectionCount + ' items still selected!!!')
  }
  if (!wasInTx) endTransaction();
}




function updateSelectedItemOnScreen(item) {
  background = isItemSelected(item)? '#AAAAAA' : null ;
  if (NS4) {
    document.layers['item_'+item.name].bgColor = background;
    if (item.fixed) {
      item.fixed.bgColor = background;
    }
  } else if (NS6) {
    document.getElementById('item_'+item.name).style.backgroundColor = background == null? "" : background;
  } else {
    document.all['item_'+item.name].style.backgroundColor = background;
  }
}


function updateGroupOnScreen(group) {
  updateGroupOnScreenHook(group)
}

function setMetaDataForItem(item) {
  setMetaDataForItemHook(item)
}

function getMetaDataForItem(item) {
  getMetaDataForItemHook(item)
}

function setMetaDataForSlot(slot) {
  setMetaDataForSlotHook(slot)
}

// invalid = active/inactive slot in invalid slot [below the line]


function isSlotActive(slot) {
  // return the status of the slot:
  // active = contents of slot in valid slot
  // inactive = inactive article in valid slot
  // empty = nothing in slot...

  // given a slot, find out what number
  if (slot.contents == null) return false;
  return getItemByName(slot.contents).active
}

function elementIndexOfSlot(slot) {
  var activeCounter = 0;
  for (var i = slot.group.firstSlotIndex; i < slot.group.lastSlotIndex+1; i++) { 
    if (isSlotActive(getSlotByIndex(i))) {
      activeCounter++;
    }
    if (slot.name == getSlotByIndex(i).name) return activeCounter;
  }
  alert("A slot's group did not contain itself: '" + slot.name + "' Check your slot/group configuration.");
  return -1;
}

function updateSelectedSlotOnScreen(slot) {
  if (slot.contents != null) {
    var background = isItemSelected(getItemByName(slot.contents))? '#AAAAAA' : null ;
  } else {
    var background = null;
  }
  if (NS4) {
    // document.layers['slot_'+slot.name+'_line'].bgColor = background;
  } else if (NS6) {
    if (document.getElementById('slot_'+slot.name+'_line')) {
      document.getElementById('slot_'+slot.name+'_line').style.backgroundColor = background == null? "" : background;
    }
  } else {
    document.all['slot_'+slot.name+'_line'].style.backgroundColor = background;
  }
}

function updateVisibilityOfItemOnScreen(item) {
  var s = findSlotWithItem(item);
  var showhide;
  if (s == null) {
//    alert("A deleted item ("+ item.name+") was specified...");
    showhide = 'hidden';
  } else {
    showhide = s.visibility;
  }
  if (NS4) {
    document.layers['item_'+item.name].visibility = showhide;
  } else if (NS6) {
    document.getElementById('item_'+item.name).style.visibility = showhide;
  } else {
    document.all['item_'+item.name].style.visibility = showhide;
  }
}

function startTransaction() {
  if (__transaction != null) {
    alert('Old transaction failed!!!');
    return;
  }
  __transaction = new Array();

  // temp variable to store meta data on related objects while
  // we reorganize the layouts...

  // for each item and slot, remember any meta data associated with 
  // the element...
  for (var i = 0; i < getItemCount(); i++) {
    getMetaDataForItem(getItemByIndex(i));
  }

}

function endTransaction() {
  if (__transaction == null) {
    alert('endTransaction(): Transaction was never started');
    return;
  }
  var commit = __transaction;
  __transaction = null;

  for (var i = 0; i < commit.length; i++) {
    if (commit[i].type == 'item') {
      updateSelectedItemOnScreen(commit[i]);
      var slot = findSlotWithItem(commit[i])
      if (slot != null) {
        moveItemToSlotOnScreen(commit[i],slot);
      }
      updateVisibilityOfItemOnScreen(commit[i]);
    } else if (commit[i].type == 'slot') {
      updateSelectedSlotOnScreen(commit[i]);
    } else if (commit[i].type == 'group') {
      updateGroupOnScreen(commit[i]);
    }
  }

  // for each meta item stored, restore the data
  for (var i = 0; i < commit.length; i++) {
    if (commit[i].type == 'item') {
      setMetaDataForItem(commit[i],commit[i].meta);
    }
    if (commit[i].type == 'slot') {
      setMetaDataForSlot(commit[i]);
    }
  }
  __transactionMeta = null;
}

function transactionContainsObject(object) {
  if (object == null) {
    alert(transactionContainsObject.caller + ' sent null to transactionContainsObject()');
    a.b.c = a.b.c;
  }
  for (var i = 0; i < __transaction.length; i++) {
    if (__transaction[i].type == object.type  
      &&__transaction[i].name == object.name)
      return true;
  }
  return false;
}

function addObjectToTransaction(object) {
  if (object == null) return;  // typically someone sending a child/parent
                               //  relationship that is null.  just ignore it.
  if (!transactionContainsObject(object)) {
    __transaction[__transaction.length] = object;
  }
}

function isInTransaction() {
  return __transaction != null;
}




// complex functions that rely on the functionality provided
// by the methods above:

function findSlotWithItemCalled(item) {
  return findSlotWithItem(getItemByName(item));
}

function findSlotWithItem(item) {
  if (item == null) alert("Someone (" + findSlotWithItem.caller + ") attempting findSlotWithItem(null)");
  var resultingSlot = null;
  for (i = 0; i < getSlotCount(); i++) {
    if (getSlotByIndex(i)) {
      if (item.name == getSlotByIndex(i).contents) {
        resultingSlot = getSlotByIndex(i);
      }
    }
  }
  if (resultingSlot == null) {
    if (info) alert('item '+item.name+' does not belong anywhere!!!');
  }
  return resultingSlot;
}



function selectItem(item) {
  // if in selectedItem, call deselectItem(slot) -- 
  if (isItemSelected(item)) {
    deselectItem(item);
    return;
  }

  // display background in different color
  highlightItem(item, true);

  for (var i = 0; i < selection.length; i++) {
    if (selection[i] == null) {
      selection[i] = item;
      return;
    }
  }
  selection[selection.length] = item;
}

function deselectItem(item) {
  highlightItem(item, false);
  for (var i = 0; i < selection.length; i++) {
    if (selection[i] == item) {
      selection[i] = null;
    }
  }
}



// Helper methods to interface with the form

function existsMovableItemCalled(item) {
  if (NS4) {
    return document['item_'+item];
  } else { 
    return document.getElementById('item_'+item)
  }
}


function existsFixedItemCalled(item) {
  if (NS4) {
    return document['fixedItem_'+item];
  } else { 
    return document.getElementById('fixedItem_'+item)
  }
}


/*
 * used by endTransaction to move items to their respective slots...
 */
function moveItemToSlotOnScreen(item,slot) {
  var showhide = slot.visibility;
  // only move items that will be visible.  
  // others, simply become invisible....
  var move = (showhide == 'visible');
  var offsetx = 5;
  var offsety = 5;

  if (NS4) {
    if (move) {
      document.layers['item_'+item.name].moveTo(document.images['slot_' + slot.name].x + offsetx,document.images['slot_' + slot.name].y+offsety)
    }
    document.layers['item_'+item.name].visibility = showhide;
  } else if (NS6) {
    if (move) {
      document.getElementById('item_'+item.name).style.top  = IE4_getRealTop(document.getElementById('slot_' + slot.name))+offsety;
      document.getElementById('item_'+item.name).style.left = IE4_getRealLeft(document.getElementById('slot_' + slot.name))+offsetx;
    }
    document.getElementById('item_'+item.name).style.visibility = showhide;
  }
}


function moveItemToSlotInData(item, slot) {
  //nop;
  slot.contents = item.name;
}

function emptySlotInData(slot) {
  //nop;
  slot.contents = null;
}




function moveSelectedItemsToSlotName(slot) {
  var wasInTx = isInTransaction();
  if (!wasInTx) startTransaction();
  moveSelectedItemsToSlot(getSlotByName(slot));
  clearSelection();
  if (!wasInTx) endTransaction();
}

function moveSelectedItemsToSlot(slot) {

  // loop through slots in slot order.
  // for each item, check if  is selected
  // if so, remember it, by pushing it into an array, at the end.
  var ToDo = new Array()
  if (getSelectionCount() == 0) {
    alert("You must select some items...");
    return;
  }
  for (var i = 0; i < getItemCount(); i++) {
    if (getSelectionIndexOfItem(getItemByIndex(i)) != -1)
      ToDo[ToDo.length] = getItemByIndex(i);
  }
  if (ToDo.length == 0) {
    alert("No items were selected!!!");
    return;
  }
  // ToDo now contains all selected items that need to be moved.

  // if we have room for them...
  //  if (!slotNames[slots[slot].index + ToDo.length-1]) return;

  // start the transaction --
  // from here on, nothing is moved on the screen, only the model is updated.
  // when we do "endTransaction", everything on the screen is updated.
  var wasInTx = isInTransaction();
  if (!wasInTx) startTransaction();

  // remove all of the items...
  // then insert them in reverse order where they are to be added.

  for (var i = 0; i < ToDo.length; i++) {
    if (findSlotWithItem(ToDo[i])) {
      //alert('removing item ' + ToDo[i].name + ' from slot ' + findSlotWithItem(ToDo[i]).name);
      removeItemFromSlotInModel(findSlotWithItem(ToDo[i]));
    }
  }

  // insert them in reverse order, the others will push the first one down...

  for (var i = ToDo.length-1; i >= 0; i--) {
    // first item should in any case not need to be moved...
    //alert('inserting item ' + ToDo[i].name + ' from slot ' + slot.name);
    insertItemIntoSlotInModel(ToDo[i],slot);
  }

  if (!wasInTx) endTransaction();
}


  function slideItemToSlot(item, targetSlot) {
    var sourceSlot = findSlotWith(item);
    // if the source and target are the same, return...
    if (sourceSlot==targetSlot) return;

    // a slide is basically a "remove" and an "insert"...

    var wasInTx = isInTransaction();
    if (!wasInTx) startTransaction();

    removeItemFromSlotInModel(slot);

    insertItemIntoSlotInModel(item,slot);

    if (!wasInTx) endTransaction();
  }

  // remove the specified item from its slot.
  // if there are items directly below it, move them up.
  function removeItemFromSlotNameInModel(slot) {
    return removeItemFromSlotInModel(getSlotByName(slot));
  }

  function removeItemFromSlotInModel(slot) {
    //alert('removing item from ' + slot.name);
    if (slot.contents == null) return;
    var wasInTx = isInTransaction();
    if (!wasInTx) startTransaction();
    addObjectToTransaction(getItemByName(slot.contents));
    addObjectToTransaction(slot);
    addObjectToTransaction(slot.group);

    emptySlotInData(slot);
    pullItemUpToSlot(slot);

    if (!wasInTx) endTransaction();
  }

  // insert the specified item into the specified slot
  // if there are items in the specified slot, push them down.
  function insertItemNameIntoSlotNameInModel(item, slot) {
    return insertItemIntoSlotInModel(getItemByName(item),getSlotByName(slot))
  }

  function insertItemIntoSlotInModel(item, slot) {
    //alert('inserting item '+item.name+' into ' + slot.name);

    slot = findAppropriateSlotToInsertInto(slot);

    var wasInTx = isInTransaction();
    if (!wasInTx) startTransaction();
    addObjectToTransaction(item);
    addObjectToTransaction(getItemByName(slot.contents));
    addObjectToTransaction(slot);
    addObjectToTransaction(slot.group);

    pushItemDownFromSlot(slot);
    moveItemToSlotInData(item, slot);

    if (!wasInTx) endTransaction();
  }


  function pullItemUpToSlot(slot) {
    //alert("Pulling up whatever is in " + slot.name);
    if (slot.contents != null) return;
    var next = getSlotAfter(slot);
    if (next == null) return;
    if (next.contents == null) return;
    // preconditions are ok, do the move...

    var wasInTx = isInTransaction();
    if (!wasInTx) startTransaction();

    slot.contents = next.contents;
    emptySlotInData(next);
    pullItemUpToSlot(next);
    addObjectToTransaction(slot);
    addObjectToTransaction(next)
    addObjectToTransaction(slot.group);
    addObjectToTransaction(next.group);
    addObjectToTransaction(getItemByName(slot.contents));

    if (!wasInTx) endTransaction();

  }

  function pushItemDownFromSlot(slot) {
    //alert("Pushing down whatever is in " + slot.name);
    if (slot.contents == null) return;
    var next = getSlotAfter(slot);
    var wasInTx = isInTransaction();
    if (!wasInTx) startTransaction();

    // if we try to push an element off the end of the list, 
    // should it be deleted?  Yes, simply remove it...
    if (next == null) {
      addObjectToTransaction(slot);
      addObjectToTransaction(slot.group);
      addObjectToTransaction(getItemByName(slot.contents));
      emptySlotInData(slot);
    } else {
      // preconditions are ok, do the move...
      pushItemDownFromSlot(next);

      addObjectToTransaction(getItemByName(slot.contents));
      next.contents = slot.contents;
      emptySlotInData(slot);
    
      addObjectToTransaction(slot.group);
      addObjectToTransaction(slot);
      addObjectToTransaction(next);

    }
    if (!wasInTx) endTransaction();
  }



function findAppropriateSlotToInsertInto(slot) {
  // find out the real slot -- by looking for the 
  // first empty slot above this one.
  var beforeSlot = getSlotBefore(slot);

  while (true) {
    if (beforeSlot == null) break;
    if (beforeSlot.contents != null) break;
    slot = beforeSlot;
    beforeSlot = getSlotBefore(slot);
  }
  return slot;
}


function moveItemToSlot(item,slot) {
  if (debug) alert('Moving '+item.name+' to '+slot.name);
  if (slot.contents == item) {
    // item already positioned in slot, according to model!
    return;
  }
  var s = findAppropriateSlotToInsertInto(slot);
  if (s.name != slot.name) {
    if (debug) alert('item ' + item.name + ' was attempted placed into slot ' + slot.name + ' --> ' + s.name);
  }
  
  // here we might queue the on-screen move...?Hmmm what to do...
  moveItemToSlotInData(item, s);
  moveItemToSlotOnScreen(item, s);
  updateVisibilityOfItemOnScreen(item);
}

function toggleSelectionForItemInSlotName(slot) {
  var s = getSlotByName(slot);
  if (s.contents == null) return;
  toggleSelectionForItem(getItemByName(s.contents));
}

function toggleSelectionForItemName(item) {
  toggleSelectionForItem(getItemByName(item));
}
function toggleSelectionForItem(item) {
  var wasInTx = isInTransaction();
  if (!wasInTx) startTransaction();
  if (! isItemSelected(item)) {
    selectItemInModel(item);
  } else {
    deselectItemInModel(item);
  }
  addObjectToTransaction(item);
  var slot = findSlotWithItem(item);
  if (slot != null) {
    addObjectToTransaction(slot);
    addObjectToTransaction(slot.group);
  }
  if (!wasInTx) endTransaction();
}





function error(message) {
  alert(message);
}

