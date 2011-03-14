jQuery.fx.interval = 500;

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
  $("#top_layer").pulsefade(60000);
  
  $(":submit").after("<div class='spinner'></div>")
  $(".spinner").hide()
  
  var options = {
    beforeSubmit: function(){
      $(".spinner").fadeIn("fast")
    },
    async: false,
    success: function(data){
      $(".spinner").fadeOut("slow")
      validation = JSON.parse(data);
      $("h3.form_error").remove()
      $("label.error").remove()
      $("input").removeClass("error")
      $("textarea").attr("class", "")
      if (validation.success) {
        if ($(".form_success").length == 0) {
          $("#contact_form").after("<div class='form_success'><h3 class='form_success'></h3></div>")
          $("h3.form_success").text("Thank you for filling out my contact form, I will be in contact with you shortly.")
          $(".form_success").hide()
        } 
        
        $("h3.form_error").remove()
        $("label.error").remove()
        $("#contact.section h3:first").fadeOut("fast")
        $("#contact_form").fadeOut("fast")
        $(".form_success").fadeIn("slow")

      } else{
          $("#contact_form").prepend("<h3 class='form_error'>There was an error when trying to submit your message, please fix the highlighted fields below.</h3>")
         
         if (validation.errors.name) {
           $("#name").addClass("error").after("<label class='error'>Please provide your name.</label>");
         };

         if (validation.errors.email) {
           $("#email").addClass("error").after("<label class='error'>Please provide a valid email.</label>");
         };

         if (validation.errors.msg) {
           $("#message").addClass("error").after("<label class='error'>Please enter a message.</label>");
         };

      };

    }
  }

  $('#contact_form').ajaxForm(options);

})
