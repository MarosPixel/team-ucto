
$('.p11n .do_add').live('ajax:success', ->
  $(this).attr('data-method', 'delete').addClass('do_delete').removeClass('do_add')
  $(this).find('span').text('Áno')
  if $(this).parent().hasClass('add-wrap')
    $(this).parent().addClass('delete-wrap').removeClass('add-wrap')
)

$('.p11n .do_delete').live('ajax:success', ->
  $(this).attr('data-method', 'post').addClass('do_add').removeClass('do_delete')
  $(this).find('span').text('-')
  if $(this).parent().hasClass('delete-wrap')
    $(this).parent().addClass('add-wrap').removeClass('delete-wrap')
)

$('.p11n .do_add').live('ajax::failure', ->
  alert('ok')
  $('#alert').text('Error')
)

$('.p11n .do_delete').live('ajax::failure', ->
  $('#alert').text('Error')
)
