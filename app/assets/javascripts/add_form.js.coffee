# $ ->
#   models = count: 0
#   $('.add_fields').on 'click', ->
#     # time = new Date().getTime()
#     models.count += 1
#     regexp = new RegExp($(this).data('id'), 'g')
#     $(this).before($(this).data('fields').replace(regexp, models.count))
#     event.preventDefault()
#
#   $('.remove_fields').on 'click', ->
#     $(this).prev('input[type=hidden]').val('1')
#     $(this).closest('fieldset').hide()
#     event.preventDefault()
