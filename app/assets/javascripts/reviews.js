$(document).on('turbolinks:load', function(){
  $(document).on('mouseover', '#stars i', function(){
    var onStar = parseInt($(this).data('value'), 10);
    $(this).parent().children('i.fa-star').each(function(e){
      if (e < onStar) {
        $(this).removeClass('rate-empty');
      }
    });
  });

  $(document).on('mouseout', '#stars', function(){
    $(this).children('i.fa-star').each(function(){
      if (!$(this).hasClass('selected-star')) {
        $(this).addClass('rate-empty');
      }
    });
  });

  $(document).on('click', '#stars i', function(){
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
