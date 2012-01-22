
$('.p11n.do_add form').live('ajax:success', ->
  $(this).parent().addClass('do_delete').removeClass('do_add')
  $(this).find('input[type="submit"]').val('-')
  $(this).append('<input name="_method" type="hidden" value="delete" />')
)

$('.p11n.do_delete form').live('ajax:success', ->
  $(this).parent().addClass('do_add').removeClass('do_delete')
  $(this).find('input[type="submit"]').val('+')
  $(this).find('input[value="delete"]').remove()
)
