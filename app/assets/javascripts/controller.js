$(document).ready (function(){
  var feelingsView = new FeelingsView($(".feelings-container"), $("#feeling-header"));
  var providersView = new ProvidersView($("#results-container"));

  $("#input-container").on('click', 'button', function(e) {
    e.preventDefault();
    search.updateSelectedFeelings($(this))

    search.findProviders().done(function(response){
      providersView.render(response.providers_html);
      feelingsView.render(response.highest_feeling_rank, response.feelings_html);

    }).fail(function(response){
      console.log(response);
    });
  });
});
