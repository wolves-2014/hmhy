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
    feelingEl.addClass('active');
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

// BeaconSearch.prototype.setBox = function (boxElement) {
//   this.box = boxElement;
//   var window = $(window);
//   boxTop = this.box.offset().top;
//   debugger;

//   window.scroll(function() {
//     this.box.toggleClass('sticky', window.scrollTop() > boxTop)
//   })
// }



var search = new BeaconSearch();
