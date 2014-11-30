$(document).ready (function(){
  $("#input-container").on('click', 'button', function(e) {
    e.preventDefault();
    $(this).toggleClass('active');
    var active = $('.active')
    var active_feelings = []
    for (var i = 0; i < active.length; i++) {
      var feeling = $(active[i]).text();
      active_feelings.push(feeling);
    }
    var request = $.ajax({
      url: "/providers",
      type: 'GET',
      data: {feelings: active_feelings}
    });

    request.done(function(response){
      $("#results-container").replaceWith(response.providers_html);
      $("#word-cloud").replaceWith(response.secondary_feelings_html);
      // $("#tertiary-feelings").html(response.tertiary_feelings_html);
    });

    request.fail(function(response){
      console.log(response);
    });
  });
});
