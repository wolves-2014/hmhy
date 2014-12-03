var BeaconSearch = function() {
  this.feelings = [];
  this.selectedFeeling = "";
};

BeaconSearch.prototype.remove = function(feeling) {
  this.feelings.splice(this.feelings.indexOf(feeling), 1);
}

BeaconSearch.prototype.updateSelectedFeelings = function(feelingEl){
  this.selectedFeeling = feelingEl.text();
  if (feelingEl.hasClass('active')) {
    feelingEl.removeClass('active');
    search.remove(this.selectedFeeling);
  } else {
    feelingEl.removeClass('active');
      search.feelings.push(this.selectedFeeling);
  }
}

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
