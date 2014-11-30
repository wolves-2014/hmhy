$(document).ready (function(){
  $("#input-container").on('click', 'a', function(e) {
    e.preventDefault();
    $(this).toggleClass('selected');

    var selected = $('.selected')
    var selected_feelings = []
    for (var i = 0; i < selected.length; i++) {
      selected_feelings.push(selected[i].text);
    }
    var request = $.ajax({
      url: "/providers",
      type: 'GET',
      data: {feelings: selected_feelings}
    });

    request.done(function(response){
      $("#results-container").replaceWith(response.providers_html);
      $("#secondary-feelings").html(response.secondary_feelings_html);
      $("#tertiary-feelings").html(response.tertiary_feelings_html);
    });

    request.fail(function(response){
      console.log(response);
    });
  });
});
