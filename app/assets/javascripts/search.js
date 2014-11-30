$(document).ready (function(){
  $("#input-container").on('click', 'button', function(e) {
    e.preventDefault();
    $(this).toggleClass('active');
    var selected_feeling = $(this).text();
    var wordLevel = $('.word-container').attr('id');
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
      if (parseInt(wordLevel) < 3) {
        $(".word-container").replaceWith(response.feelings_html);
        if (!$('#feeling-header').hasClass('changed')) {
          $("#feeling-header").html("<h3>You said you're feeling " + selected_feeling + ".</h3><br><h4>Do any of these apply to you?</h4>");
          $("#feeling-header").addClass('changed');
        }
      }
    });

    request.fail(function(response){
      console.log(response);
    });
  });
});
