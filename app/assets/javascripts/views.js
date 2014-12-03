function ProvidersView(container) {
  this.container = container;
}

ProvidersView.prototype.render = function(providersHTML) {
  this.container.replaceWith(providersHTML);
}

function FeelingsView(container, header) {
  this.container = container;
  this.header = header;
}

FeelingsView.prototype.render = function(feelingsHTML) {
  var wordLevel = $('.word-container').attr('id');
  if (parseInt(wordLevel) < 3) {
    this.header.fadeOut('slow');
    this.container.fadeOut('slow', function(){
      this.container.html(feelingsHTML);
      this.container.fadeIn('slow');
      this.updateHeader();
      this.header.fadeIn('slow');
    }.bind(this));
  }
}

FeelingsView.prototype.fade = function() {
}

FeelingsView.prototype.updateHeader = function() {
  if (!this.header.hasClass('changed')) {
    this.header.html("<h3 class='text-shadow no-top-margin'>You said you're feeling " + search.selectedFeeling + ".</h3><h2 class='text-shadow'>Do any of these apply to you?</h2>");
    this.header.addClass('changed');
  }
}
