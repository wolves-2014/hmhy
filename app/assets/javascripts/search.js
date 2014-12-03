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
