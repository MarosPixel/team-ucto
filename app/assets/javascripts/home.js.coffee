jQuery ->

  #$('#content').css('min-height', ($(window).height()-120-110) + 'px')

  # vypise chybu do konzoly, ak neexistuje preklad pre nejaky text
  $('.translation_missing').each -> console.error($(this).attr('title'))
