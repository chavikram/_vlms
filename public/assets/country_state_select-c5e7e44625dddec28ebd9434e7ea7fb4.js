$(document).on('ready page:load', function () {

  
  $("#country_id").change(function() {
    var country = $('#country_id option:selected').text()
    var options = '';
    $('#state_name').html('');
    find_csc('/find_states', $("#country_id").val());
  });
  var find_csc = function(url, id){
    $.ajax({
      url: url,
      type: 'post',
      dataType: 'json',
      cache: false,
      data: {
        country_id: id 
      },
      success:function(data) {
        create_select(data) ;
      }
    });
  }
  var create_select = function(data){
    if (data.length === 0){
      $html = "<input id='state_name' name="+ name +" class="+class_name+" type='text' value='' />"
    }else{
      name = $('#state_name').attr('name');
      class_name = $('#state_name').attr('class');
      $html= '<select class='+class_name+' id="state_name" name='+name+' >'		
      $html+='<option selected=\"selected\"' +' value='+1 +'>'+data[0][1]+'</option>';
      
      for ( var idcount = 1; idcount < data.length; idcount++) {
	    $html+='<option'+' value=' + data[idcount][0] +'>'+data[idcount][1]+'</option>';
	  }
      $html+='</select>';		   
    }
    
    $('#state_name').replaceWith($html);
    if (class_name === 'chosen-select' && data.length >0){
      $('.'+class_name+'').chosen();
    }
   
   }
       $('#state_name').html('');
    find_csc('/find_states', $("#country_id").val());
 
});

    
