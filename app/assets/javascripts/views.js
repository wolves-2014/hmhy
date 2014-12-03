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

FeelingsView.prototype.render = function(wordLevel, feelingsHTML) {
  if (parseInt(wordLevel) < 3) {
    this.container.replaceWith(feelingsHTML);
  }
}

FeelingsView.prototype.updateHeader = function(selectedFeeling) {
  if (!this.header.hasClass('changed')) {
    this.header.html("<h3 class='text-shadow'>You said you're feeling " + selectedFeeling + ".</h3><h2 class='text-shadow'>Do any of these apply to you?</h2>");
    this.header.addClass('changed');
  }
}
