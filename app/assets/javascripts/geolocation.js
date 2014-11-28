$(document).ready(function(){
  $("#search").submit(function(e){
    e.preventDefault();

    var x = document.getElementById("demo");
    getLocation();

    function getLocation() {
      if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(showPosition);
      } else {
          x.innerHTML = "Geolocation is not supported by this browser.";
      }
    }

    function showPosition(position) {
      x.innerHTML = "Latitude: " + position.coords.latitude +
      "<br>Longitude: " + position.coords.longitude;
    }
  });
});
