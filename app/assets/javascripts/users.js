document.addEventListener("turbolinks:load", function() {

   $('#remove').on("click", function() {
      if($(this).is(":checked")) {
        $('#remove_button').attr('class', 'btn btn-default mb-20')
         return;
      }
      $('#remove_button').attr('class', 'btn disabled mb-20')
   });

})