jQuery.fx.interval = 100;

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
 // $("#top_layer").pulsefade(60000);
 // $("#top_layer").pulsefade(30000);
 $("#top_layer").pulsefade(10000);
 // $("#top_layer").pulsefade(5000);
})
