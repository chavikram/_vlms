# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.toggle').click (event) ->
    event.preventDefault()
    target = $(this).attr('href')
    $(target).toggleClass 'hidden show'
    return
  return
  
$ ->
  $(document).on 'change', '#countries_select', (evt) ->
    $.ajax 'update_states',
      type: 'GET'
      dataType: 'script'
      data: {
        country_id: $("#countries_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic country select OK!")

$ ->
  $(document).on 'change', '#vip_reference_category_id', (evt) ->
    $.ajax '/categories/listofSubCategories',
      type: 'GET'
      dataType: 'json'
      data: {
        category_id: $("#vip_reference_category_id option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
      	html1=""
      	for key in data
            html1 += "<option value=" + key['id']  + ">" + key['text'] + "</option>"

        $("#vip_reference_vip_category_id").html(html1)
        console.log("Dynamic country select OK!")

$ ->
  $(document).on 'change', '#category_id', (evt) ->
    $.ajax '/categories/listofSubCategories',
      type: 'GET'
      dataType: 'json'
      data: {
        category_id: $("#category_id option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
      	html1="<option value=\"0\">All</option>"
      	for key in data
            html1 += "<option value=" + key['id']  + ">" + key['text'] + "</option>"

        $("#vip_category_id").html(html1)
        console.log("Dynamic country select OK!")
        