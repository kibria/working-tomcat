//<![CDATA[
var map;
var markers = [];

function load() {
  var mapOptions = {
    center: new google.maps.LatLng(0.0, 0.0),
    zoom: 2,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    draggable: true
  };
  map = new google.maps.Map(document.getElementById("resultGoogleMap"), mapOptions);

  var bounds = new google.maps.LatLngBounds();
  for(i in markers) {
    var marker = markers[i];
    marker.setMap(map);
    bounds.extend(marker.getPosition());
  }
  map.fitBounds(bounds);
}

function addMarker(latitude, longitude, imageURL, htmlText) {
  var markerOptions = {
    position: new google.maps.LatLng(latitude, longitude),
    draggable: false,
    icon: imageURL
  };
  var marker = new google.maps.Marker(markerOptions);
  markers.push(marker);

  google.maps.event.addListener(marker, 'click', function(mouseEvent) {
    infoWindow = new google.maps.InfoWindow({content: "<b>" + htmlText + "</b>"});
    infoWindow.open(map, marker);
  });
}

google.maps.event.addDomListener(window, 'load', load);