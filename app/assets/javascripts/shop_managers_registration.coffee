$ ->
  $('.employee-check input[type=radio]').change (e) ->
    #数値型であっても判定するときは文字列となる
    if e.target.value == '20'
      $('.coupon-time-click').css 'display', 'none'
    else
      $('.coupon-time-click').css 'display', 'block'
    return
  return
