(function() {
  $(function() {
    $('.toggle').click(function(event) {
      var target;
      event.preventDefault();
      target = $(this).attr('href');
      $(target).toggleClass('hidden show');
    });
  });

  $(function() {
    return $(document).on('change', '#countries_select', function(evt) {
      return $.ajax('update_states', {
        type: 'GET',
        dataType: 'script',
        data: {
          country_id: $("#countries_select option:selected").val()
        },
        error: function(jqXHR, textStatus, errorThrown) {
          return console.log("AJAX Error: " + textStatus);
        },
        success: function(data, textStatus, jqXHR) {
          return console.log("Dynamic country select OK!");
        }
      });
    });
  });

  $(function() {
    return $(document).on('change', '#vip_reference_category_id', function(evt) {
      return $.ajax('/categories/listofSubCategories', {
        type: 'GET',
        dataType: 'json',
        data: {
          category_id: $("#vip_reference_category_id option:selected").val()
        },
        error: function(jqXHR, textStatus, errorThrown) {
          return console.log("AJAX Error: " + textStatus);
        },
        success: function(data, textStatus, jqXHR) {
          var html1, i, key, len;
          html1 = "";
          for (i = 0, len = data.length; i < len; i++) {
            key = data[i];
            html1 += "<option value=" + key['id'] + ">" + key['text'] + "</option>";
          }
          $("#vip_reference_vip_category_id").html(html1);
          return console.log("Dynamic country select OK!");
        }
      });
    });
  });

  $(function() {
    return $(document).on('change', '#category_id', function(evt) {
      return $.ajax('/categories/listofSubCategories', {
        type: 'GET',
        dataType: 'json',
        data: {
          category_id: $("#category_id option:selected").val()
        },
        error: function(jqXHR, textStatus, errorThrown) {
          return console.log("AJAX Error: " + textStatus);
        },
        success: function(data, textStatus, jqXHR) {
          var html1, i, key, len;
          html1 = "<option value=\"0\">All</option>";
          for (i = 0, len = data.length; i < len; i++) {
            key = data[i];
            html1 += "<option value=" + key['id'] + ">" + key['text'] + "</option>";
          }
          $("#vip_category_id").html(html1);
          return console.log("Dynamic country select OK!");
        }
      });
    });
  });

}).call(this);
