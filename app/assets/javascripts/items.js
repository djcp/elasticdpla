// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//

$(document).ready(function(){
  $('#search').submit(function(e){
    e.preventDefault();
    $.ajax({
      method: 'get',
      url: $(this).attr('action'),
      dataType: 'json',
      beforeSend: function(){
       $('#button').val('... please wait ...'); 
      },
      complete: function(){
       $('#button').val('Search'); 
      },
      data: {keyword: $('#keyword').val()},
      success: function(json){
        $('#search_target').html('<h3>' + json.total + ' records found.</h3>');
        $('#search_target').append('<p>Results as json: <a href="' + json.as_json +  '">' + json.as_json + '</a></p>');
        $('#search_target').append('<ul></ul>');
        $(json.items).each(function(i,el){
          $('#search_target ul').append('<li><a href="/items/show/' + el.id + '">' + el.title + '</a></li>');
        });
        if(json.length == 0){
          $('#search_target').html('<p style="color:red; font-weight: bold">Nothing found. Please enter a different term</p>');
        }
     },
     error: function(){
       $('#search_target').html('<p style="color:red; font-weight: bold">Nothing found. Please enter a different term</p>');
     }
   });
  });
  
});
