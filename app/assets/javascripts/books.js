$(document).on('turbolinks:load', function(){
  $('#minus').on("click", function(e){
    var current_value = $('.input-count-book').val();
    if (current_value >= 2) {
      var new_value = Number(current_value) - 1;
      $('.input-count-book').val(new_value);
    }
  })

  $('#plus').on("click", function(e){
    var current_value = $('.input-count-book').val();
    var new_value = Number(current_value) + 1;
    $('.input-count-book').val(new_value);
  })

  $('#btn_read_more').on("click", function () {
    $('#more_text').css('display', 'inline');
    $('#btn_read_more').css('display', 'none');
    $('#hide_read_more').css('display', 'inline-block');
    $('#short_text').css('display', 'none');
  });

  $('#hide_read_more').on("click", function (){
    $('#btn_read_more').css('display', 'inline-block');
    $('#hide_read_more').css('display', 'none');
    $('#more_text').css('display', 'none');
    $('#short_text').css('display', 'inline');
  });

  $('#stars i').on('mouseover', function(){
    var onStar = parseInt($(this).data('value'), 10);
    $(this).parent().children('i.fa-star').each(function(e){
      if (e < onStar) {
        $(this).removeClass('rate-empty');
      }
      else {
        if (!$(this).hasClass('selected-star')) {
          $(this).addClass('rate-empty');
        }
      }
    });
  }).on('mouseout', function(){
    $(this).parent().children('i.fa-star').each(function(e){
      if (!$(this).hasClass('selected-star')) {
        $(this).addClass('rate-empty');
      }
    });
  });

  $('#stars i').on('click', function(){
    var onStar = parseInt($(this).data('value'), 10);
    var stars = $(this).parent().children('i.fa-star');

    for (i = 0; i < stars.length; i++) {
      $(stars[i]).removeClass('selected-star');
    }

    for (i = 0; i < onStar; i++) {
      $(stars[i]).addClass('selected-star');
    }

    for (i = onStar; i < stars.length; i++) {
      $(stars[i]).addClass('rate-empty');
    }

    var ratingValue = parseInt($('#stars i.selected-star').last().data('value'), 10);
    $('#review_book_rate').val(ratingValue);
  });
})
