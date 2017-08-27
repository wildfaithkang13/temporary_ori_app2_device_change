# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#coupon-check(クーポン投稿利用登録の24時間営業チェックの内容によって時間設定の有効 / 無効を捜査する)
$ ->
  $('.coupon-check input[type=radio]').change (e) ->
    if e.target.value == 'true'
      $('.coupon-time-click').css 'display', 'none'
    else
      $('.coupon-time-click').css 'display', 'block'
    return
  return
