$(document).on('turbolinks:load', function(){
    
    $('#order_only_billing').on('click', function() {
        if($(this).is(":checked")) {
          $('#shipping_address_form').hide()
        }
        else {
            $('#shipping_address_form').show()
        }
     });

  })
  