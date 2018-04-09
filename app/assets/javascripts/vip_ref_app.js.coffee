# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

printPage = ->
  $('#printable tr').find('th:last, td:last').hide()
  #$("tr > td:last").hide();
  $('#printable').print prepend: 'Hello'
  window.location.reload()
  return
