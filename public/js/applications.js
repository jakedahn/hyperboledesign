jQuery.fx.interval = 2000;

$.fn.pulsefade = function(interval) {
  return this.each(function() {
    $this = $(this);
    $this.animate({ 'opacity': 'toggle' }, interval);
    
    setInterval(function(){
      $this.animate({ 'opacity': 'toggle' }, interval);
    }, interval)
  });
};

$(function(){
 $("#top_layer").pulsefade(360000);
})
