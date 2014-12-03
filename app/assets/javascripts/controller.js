$(document).ready (function(){
  var providersView = new ProvidersView($("#results-container"));
  var feelingsView = new FeelingsView($(".word-container"), $("#feeling-header"));

  $("#input-container").on('click', 'button', function(e) {
    e.preventDefault();
    var wordLevel = $('.word-container').attr('id');
    search.updateSelectedFeelings($(this))

    search.findProviders().done(function(response){
      providersView.render(response.providers_html);
      feelingsView.render(wordLevel, response.feelings_html);

    }).fail(function(response){
      console.log(response);
    });
  });
});
