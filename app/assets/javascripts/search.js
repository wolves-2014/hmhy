$(document).ready (function(){
 $("#input-container a").click(function(e){
  e.preventDefault();

  var request = $.ajax({
    url: "/providers",
    type: 'GET',
    data: {feeling: $(this).text()}
  });

  request.done(function(response){
    $("#results-container").replaceWith(response.html);
  });

  request.fail(function(response){
    console.log(response);
  });

 });






});
