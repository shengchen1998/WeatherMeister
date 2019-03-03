<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Showing Pixel and Tile Coordinates</title>
    <meta name="viewport" content="initial-scale=1.0">
    <meta charset="utf-8">
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>
  </head>
  <body>
    <div id="map"></div>
    <script>
      function initMap() {
        var chicago = new google.maps.LatLng(41.850, -87.650);
     
        var map = new google.maps.Map(document.getElementById('map'), {
          center: chicago,
          zoom: 3
        });
        
        var coordInfoWindow = new google.maps.InfoWindow();
        coordInfoWindow.setContent(createInfoWindowContent(chicago, map.getZoom()));
        coordInfoWindow.setPosition(chicago);
        coordInfoWindow.open(map);
        
        google.maps.event.addListener(map, 'click', function(event) {
            var marker = addMarker(event.latLng, map);
            coordInfoWindow.setContent(createInfoWindowContent(marker.getPosition(), map.getZoom()));
            coordInfoWindow.setPosition(marker.getPosition());
            coordInfoWindow.open(map);
          });
      }

      var TILE_SIZE = 256;
      
      function addMarker(location, map) {
          var marker = new google.maps.Marker({
            position: location,
            map: map
          });
          return marker;
        }
      function createInfoWindowContent(latLng, zoom) {
        var scale = 1 << zoom;

        var worldCoordinate = project(latLng);

        var pixelCoordinate = new google.maps.Point(
            Math.floor(worldCoordinate.x * scale),
            Math.floor(worldCoordinate.y * scale));

        var tileCoordinate = new google.maps.Point(
            Math.floor(worldCoordinate.x * scale / TILE_SIZE),
            Math.floor(worldCoordinate.y * scale / TILE_SIZE));

        return [
          'Chicago, IL',
          'LatLng: ' + latLng,
          'Zoom level: ' + zoom,
          'World Coordinate: ' + worldCoordinate,
          'Pixel Coordinate: ' + pixelCoordinate,
          'Tile Coordinate: ' + tileCoordinate
        ].join('<br>');
      }
      function project(latLng) {
        var siny = Math.sin(latLng.lat() * Math.PI / 180);
        siny = Math.min(Math.max(siny, -0.9999), 0.9999);

        return new google.maps.Point(
            TILE_SIZE * (0.5 + latLng.lng() / 360),
            TILE_SIZE * (0.5 - Math.log((1 + siny) / (1 - siny)) / (4 * Math.PI)));
      }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCBvMZojeC8Sg3TpMpzOI2kMLAosMnVqN0&callback=initMap">
    </script>
  </body>
</html>