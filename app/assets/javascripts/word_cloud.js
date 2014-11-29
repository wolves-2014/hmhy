
$(document).ready(function(){
  var words = $('#word-cloud').children();
  // animateWord(words[0]);

  for (var i = 0; i < words.length; i++){
    animateWord(words[i]);
  }
});

function makeNewPosition(){

    // Get viewport dimensions (remove the dimension of the div)
    var h = $('#word-cloud').height() - 140;
    var w = $('#word-cloud').width() - 80;

    var nh = Math.floor(Math.random() * h);
    var nw = Math.floor(Math.random() * w);

    return [nh,nw];

}

function animateWord(word){
  var el = $(word)

  var newq = makeNewPosition();
  var oldq = el.offset();

  var container = $('#word-cloud');
  var width = container.innerWidth() - el.outerWidth();
  var height = container.innerHeight() - el.outerHeight();

  var speed = calcSpeed([oldq.top, oldq.left], newq);
  $(word).animate({ top: newq[0], left: newq[1] }, speed, function(){
    animateWord(word);
  }).bind(word);

};

function calcSpeed(prev, next) {
  var x = Math.abs(prev[1] - next[1]);
  var y = Math.abs(prev[0] - next[0]);

  var greatest = x > y ? x : y;

  var speedModifier = 0.007;

  var speed = Math.ceil(greatest/speedModifier);

  return speed;

}

