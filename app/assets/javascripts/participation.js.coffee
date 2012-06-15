$(document).ready ->
  
  $('.participation').on('ajax:success', '.do_add', ->
    $(this).attr('data-method', 'delete').data('method', 'delete').addClass('do_delete').removeClass('do_add')
    $(this).find('span').text('Áno')
    if $(this).parent().hasClass('add-wrap')
      $(this).parent().addClass('delete-wrap').removeClass('add-wrap')
  )
  
  $('.participation').on('ajax:success', '.do_delete', ->
    $(this).attr('data-method', 'post').data('method', 'post').addClass('do_add').removeClass('do_delete')
    $(this).find('span').text('-')
    if $(this).parent().hasClass('delete-wrap')
      $(this).parent().addClass('add-wrap').removeClass('delete-wrap')
  )
  
  $('.p11n').on('ajax:error', 'a', ->
    $('#alert').text('Udalosť je uzamknutá, alebo nemáš právo na zmenu prihlasovania. Skús znova načítať stránku.')
  )
