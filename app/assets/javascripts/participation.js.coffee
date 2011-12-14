# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
$('.p11n.do_add form').live('ajax:success', ->
  alert 'hegfsd'
  $(this).addClass('do_delete').removeClass('do_add')
  $(this).closest('input').val('-').append('<input name="_method" type="hidden" value="delete" />'))
