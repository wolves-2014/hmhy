var BeaconSearch = function() {
  this.feelings = [];
};

BeaconSearch.prototype.findProviders = function(callback) {
  return $.ajax({
    url: "/providers",
    type: 'GET',
    data: {feelings: this.feelings}
  });
};

var search = new BeaconSearch();

$(document).ready (function(){
  var providersView = new ProvidersView($("#results-container"));
  var feelingsView = new FeelingsView($(".word-container"), $("#feeling-header"));

  $("#input-container").on('click', 'button', function(e) {
    e.preventDefault();
    $(this).toggleClass('active');
    var selected_feeling = $(this).text();
    var wordLevel = $('.word-container').attr('id');
    var active = $('.active');

    search.feelings = [];
    for (var i = 0; i < active.length; i++) {
      var feeling = $(active[i]).text();
      search.feelings.push(feeling);
    }

    search.findProviders().done(function(response){
      providersView.render(response.providers_html);
      feelingsView.render(wordLevel, response.feelings_html);
      feelingsView.updateHeader(selected_feeling);

    }).fail(function(response){
      console.log(response);
    });
  });
});
