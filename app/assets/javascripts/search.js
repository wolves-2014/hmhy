
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

function ProviderView(el) {
  this.el;
}

ProvidersView.prototype.render = function(providersHTML) {
  this.el.replaceWith(providersHTML);
}

function FeelingsView(el) {
  this.el
}

FeelingsView.prototype.render = function(feelingsHTML) {
  if (parseInt(wordLevel) < 3) {
    this.el.replaceWith(feelingsHTML);
    if (!$('#feeling-header').hasClass('changed')) {
      $("#feeling-header").html("<h3 class='text-shadow'>You said you're feeling " + selected_feeling + ".</h3><h2 class='text-shadow'>Do any of these apply to you?</h2>");
      $("#feeling-header").addClass('changed');
    }
  }
}

$(document).ready (function(){
  var providersView = new ProvidersView($("#results-container"))
  var feelingsView = new FeelingsView($(".word-container"))

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
      feelingsView.render(response.feelings_html);

    }).fail(function(response){
      console.log(response);
    });
  });
});
