

$(document).ready(function(){
  //figure out how many items to load
  document.getElementById('viewport').style.height="320px";
  function onResize(){
    var height = $('#viewport').height();
    var items = Math.floor((height - 40)/28);
    getContent(getUrlVars()['url'] + '?count=' + items);
  }
  $(window).bind('resize', function(){
     timer && clearTimeout(timer);
     timer = setTimeout(onResize, 500);
  });

  jQuery.i18n.properties({
    name: "ArticleHistory",
    path: "bundle/",
    mode: "map",
    language: getUrlVars()['language'],
    callback: onResize
  });
});

function getUrlVars() {
  //init
  var vars = [], hash;
  //getting & splitting query string
  var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
  //picking out param's
  for(var i = 0; i < hashes.length; i++) {
    hash = hashes[i].split('=');
    vars.push(hash[0]);
    vars[hash[0]] = hash[1];
  }
  //returning array
  return vars;
}

function parseDate(timeStamp){
  //init
  var date = new Date(Date.parse(timeStamp));
  var amo,mo,d,h,m,s;
  //month adjustment
  amo = date.getMonth() + 1;
  //making double digit
  mo = (amo < 10) ? '0' + amo : amo;
  d = (date.getDate() < 10) ? '0' + date.getDate() : date.getDate();
  h = (date.getHours() < 10) ? '0' + date.getHours() : date.getHours();
  m = (date.getMinutes() < 10) ? '0' + date.getMinutes() : date.getMinutes();
  s = (date.getSeconds() < 10) ? "0" + date.getSeconds() : date.getSeconds();
  //building & returning date string
  return date.getFullYear() + '-' + mo + '-' + d + ' ' + h + ':' + m + ':' + s;
}

function getContent(path) {
  //fetch xml
  $.ajax({
    type: "GET",
    url: path,
    dataType: "xml",
    beforeSend: function(jqXHR, settings){
      $(".revisions").html('<div class="loading"><img src="gfx/spinner.gif"></div>');
      jqXHR.setRequestHeader("Accept-Language", getUrlVars()['language']);
    },
    success: function(xml){
      //resetting links
      $('.newer').addClass('inactive').html('&nbsp;');
      $('.older').addClass('inactive').html('&nbsp;');
      //figuring out the links
      $(xml).find("link").each(function (index) {
        //turning active links ON (next = older | prev = newer)
        if($(this).attr('rel') == 'previous') {
          console.log('Adding link for NEWER items');
          $('.newer').removeClass('inactive');
          $('.newer').html('<a href="' + $(this).attr('href') +'">Newer</a>');
        }
        if($(this).attr('rel') == 'next') {
          console.log('Adding link for OLDER items');
          $('.older').removeClass('inactive');
          $('.older').html('<a href="' + $(this).attr('href') +'">Older</a>');
        }
        //activate button override for new elements
        $('.button a').bind('click', function(e) {
            e.preventDefault();
            getContent($(this).attr('href'));
        });
      });
      //handling the data response
      $(".revisions").html('');
      $(xml).find("entry").each(function (index) {
        //init
        var count = index + 1;
        var state, date;
        var user = $(this).find('name').text();
        //handle dates
        date = parseDate($(this).find('updated').text());
        //handle states
        if($(this).find('app\\:draft, encoded').text() == 'yes'){
          if($(this).find('metadata\\:deleted, encoded').length > 0) {
            state = 'deleted';
          } else {
            state = $(this).find('vaext\\:state, encoded').attr('name') == '' ? 'draft' : $(this).find('vaext\\:state, encoded').attr('name');
          }
        } else {
          state = 'published';
        }
        //generate output
        $(".revisions").append(
          '<div class="item">' +
            '<div class="group">' +
              //'<div class="count">' + count + '</div>' +
              '<div class="state"><img src="gfx/state-' + state + '.png" alt="' + state + '" title="' + state + '"></div>' +
              '<div class="date">' + date + '</div>' +
              '<div class="user">' + user + '</div>' +
            '</div>' +
          '</div>'
        );
      });
    },
    error: function (jqXHR, error, errorThrown) {
      var message = null;
      if (jqXHR.status) {
        message = jQuery.i18n.prop('error.' + jqXHR.status);
      }
      if (!message) {
        message = jQuery.i18n.prop('error.unknown');
      }
      $(".revisions").html('<div class="error">' + message + '</div>');
    }
  });
}
