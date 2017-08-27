$(function(){
  $("#button").on('click', function(){
    let address = $("#address").val()
   codeAddress(address);
 　})

 function codeAddress(address) {
   var geocoder = new google.maps.Geocoder();
   geocoder.geocode( { 'address': address}, function(results, status) {
     // ジオコーディングが成功した場合
     if (status == google.maps.GeocoderStatus.OK) {

       var map = new google.maps.Map(document.getElementById('map'), {
         zoom: 15,
         /* 設定した住所が地図の真ん中にくるように設定*/
         center: results[0].geometry.location
         /* center: {lat: -34.397, lng: 150.644} */
       });

       var marker = new google.maps.Marker({
         /* このポジションがピンをさす場所を表している */
         position:results[0].geometry.location,
         map: map,
       });

       marker.addListener('click', function() {
         infowindow.open(map, marker);
       });
     // ジオコーディングが成功しなかった場合
     } else {
       console.log('Geocode was not successful for the following reason: ' + status);
     }
   });
 }
});
