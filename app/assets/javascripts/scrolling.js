$(document).ready(function(){
  $('.container-fluid').bind('mousewheel', function(e){
    if(e.wheelDelta/120 > 0) {
      console.log('scrolling up !');
    }
    else{
      console.log('scrolling down !');
    }
  });
});
