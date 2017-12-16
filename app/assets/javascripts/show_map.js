//ページ読み込み完了時に現在地周辺の地図を表示する
//参考サイト：http://bashalog.c-brains.jp/17/08/25-200000.php
//現在地を取得する
//参考サイト：http://cly7796.net/wp/javascript/to-be-displayed-on-the-map-to-get-your-location-geolocation-api/
/*
情報ウィンドウのカスタマイズ方法
https://maps.multisoup.co.jp/blog/787/
情報ウィンドウにリンクを設定する方法
http://phpjavascriptroom.com/?t=ajax&p=googlemapsapiv3_infowindow
*/
$(function(){
  /*住所を入れて検索ボタンを押すと以下が動く*/
  $("#button").on('click', function(){
    let address = $("#address").val()
    /*index.htmlから渡された<%= @googlemaps %>をgeocodedShopListに代入する*/
    let geocodedShopList = $('#hoge').data("hoge-id");
   codeAddress(address, geocodedShopList);
 　})
 /*検索結果が地図に表示させる処理*/
 function codeAddress(address, geocodedShopList) {
   var marker = [];
   var geocoder = new google.maps.Geocoder();
   geocoder.geocode( { 'address': address}, function(results, status) {
     // ジオコーディングが成功した場合
     if (status == google.maps.GeocoderStatus.OK) {
       var map = new google.maps.Map(document.getElementById('map-canvas'), {
         zoom: 17,
         /* 設定した住所が地図の真ん中にくるように設定*/
         center: results[0].geometry.location
       });
       var url = "/coupon_shop_lists/";
        for (var i = 0; i < geocodedShopList.length; i++) {
          markerLatLng = new google.maps.LatLng({lat: geocodedShopList[i]['shop_latitude'], lng: geocodedShopList[i]['shop_longtitude']});
               marker[i] = new google.maps.Marker({
                 /* このポジションがピンをさす場所を表している */
                 position: markerLatLng,
                 map: map,
               });

              infoWindow[i] = new google.maps.InfoWindow({ // 吹き出しの追加
                    content : "<div id='designShowShopName'><a href='" + url + geocodedShopList[i]['id'] + "'>"+ geocodedShopList[i]['shop_name']+ "</a><br>" +
                              "<span>" +　"業種：" + geocodedShopList[i]['occupation_code'] + "</span><br>"
               });
              markerEvent(i);
        }

        function markerEvent(i) {
          marker[i].addListener('click', function() {
            infoWindow[i].open(map, marker[i]); // 吹き出しの表示
        });
      }
     // ジオコーディングが成功しなかった場合
     } else {
       console.log('Geocode was not successful for the following reason: ' + status);
     }
   });
 }
});

//ページの読み込みが完了したら現在地周辺を取得する
$(document).ready(function(){
  var geocodedShopList = $('#hoge').data("hoge-id");
  hereMap(geocodedShopList);
});

var map;
var marker = [];
var infoWindow = [];
function hereMap(geocodedShopList) {
    if (!navigator.geolocation) {
        alert('Geolocation APIに対応していません');
        return false;
    }

    var show_coupon_list = new Array();
    var json_coupon_list;
    // 現在地の取得
    navigator.geolocation.getCurrentPosition(function(position) {
        // 現在地の緯度経度の取得
        latLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

        // 地図の作成(現在地を真ん中に設定する)
        map = new google.maps.Map(document.getElementById('map-canvas'), {
            center: latLng,
            zoom: 17
        });
        // DBに登録されているお店の緯度軽度を取得する
        for (var i = 0; i < geocodedShopList.length; i++) {
          markerLatLng = new google.maps.LatLng({lat: geocodedShopList[i]['shop_latitude'], lng: geocodedShopList[i]['shop_longtitude']});
               marker[i] = new google.maps.Marker({
                 /* このポジションがピンをさす場所を表している */
                 position: markerLatLng,
                 map: map,
               });
               //2点間の距離を求める方法：参考サイト http://wp.developapp.net/?p=2833
               infoWindow[i] = new google.maps.InfoWindow({ // 吹き出しの追加
                 content : "<div id='designShowShopName'><a href='" + "coupon_shop_lists/" + geocodedShopList[i]['id'] + "'>"+ geocodedShopList[i]['shop_name']+ "</a><br>" +
                           "<span>" +　"業種：" + geocodedShopList[i]['occupation_code'] + "</span><br>"

              });
              let x1 = position.coords.latitude
              let y1 = position.coords.longitude
              let x2 = geocodedShopList[i]['shop_latitude']
              let y2 = geocodedShopList[i]['shop_longtitude']
              markerEventGPS(i);
              //計算結果をkmで返す
              //引用元：http://www.geodatasource.com/developers/javascript
              let getDistanceResult = distance(x1, y1, x2, y2, "K")
              //小数第3位以下を切り捨てる
              let secondDecimalDistance = Math.floor( getDistanceResult * Math.pow( 10, 3) ) / Math.pow( 10, 3) ;
              //取得結果をメートルに変換する
              secondDecimalDistance = secondDecimalDistance * 1000
              //クーポン表示の境界線は現在値から3km以内とする
              let showCouponBorder = 3000;
              if(secondDecimalDistance < showCouponBorder){
                  //クーポン表示フラグをtrueにする(一時変数)
                  show_coupon_list.push(geocodedShopList[i]);

              }
        }
        json_coupon_list = JSON.stringify(show_coupon_list);
        var url = location.href ;
        //参考サイト：http://qiita.com/QUANON/items/dd39be7602f9e7226e8e
        //couponsコントローラーのgetcouponsアクションへリクエストする
         $.ajax({
           type: "get",
           url: url + "/getcoupons/",
           data: { target_shop_list: json_coupon_list}
         }).done(function(data){ //ajaxの通信に成功した場合
         }).fail(function(data){ //ajaxの通信に失敗した場合
         	alert("予期せぬエラーにより地図を表示できません。");
         });

        function markerEventGPS(i) {
          marker[i].addListener('click', function() { // マーカーをクリックしたとき
            infoWindow[i].open(map, marker[i]); // 吹き出しの表示
        })}

        function distance(lat1, lon1, lat2, lon2, unit) {
          	var radlat1 = Math.PI * lat1/180
          	var radlat2 = Math.PI * lat2/180
          	var theta = lon1-lon2
          	var radtheta = Math.PI * theta/180
          	var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
          	dist = Math.acos(dist)
          	dist = dist * 180/Math.PI
          	dist = dist * 60 * 1.1515
            //Kの場合はキロメートルで返す
          	if (unit=="K") { dist = dist * 1.609344 }
            //Nの場合は海里単位で返す
          	if (unit=="N") { dist = dist * 0.8684 }
            //上記意外は法定マイルで返す
          	return dist
        }
    })
}
