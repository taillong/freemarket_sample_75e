$(function() {
  $('.user_box').mouseover(function() {
    $(this).css('background', '#EEEEEE')
  });

  $('.user_box').mouseout(function() {
    $(this).css('background', '#ffffff')
  })

  $('.user__message__block__title2').on('click', function() {
    $('.user__message__block__title1').css('background', '#EEEEEE');
    $('.user__message__block__title1').css('border-top', 'none');
    $('.user__message__block__title2').css('background', '#ffffff');
    $('.user__message__block__title2').css('border-top', '2px solid red');
    $('.user__message__content').hide();
    $('.user__message__list').show();
  })

  $('.user__message__block__title1').on('click', function() {
    $('.user__message__block__title1').css('background', '#ffffff');
    $('.user__message__block__title1').css('border-top', '2px solid red');
    $('.user__message__block__title2').css('background', '#EEEEEE');
    $('.user__message__block__title2').css('border-top', 'none');
    $('.user__message__list').hide();
    $('.user__message__content').show();
    $('.user__message__list').hide();
  })

  $('.user__message__look__btn').mouseout(function() {
    $(this).css('background', '#EEEEEE');
  })

  $('.user__message__look__btn').mouseover(function() {
    $(this).css('background', '#EEFFFF');
  })

  $('.user__product__trading__block2').on('click', function() {
    $('.user__product__trading__block1').css('background', '#EEEEEE');
    $('.user__product__trading__block1').css('border-top', 'none');
    $('.user__product__trading__block2').css('background', '#ffffff');
    $('.user__product__trading__block2').css('border-top', '2px solid red');
    $('.user__product__item').hide();
    $('.user__product__past').show();
  });

  $('.user__product__trading__block1').on('click', function() {
    $('.user__product__trading__block1').css('background', '#ffffff');
    $('.user__product__trading__block1').css('border-top', '2px solid red');
    $('.user__product__trading__block2').css('background', '#EEEEEE');
    $('.user__product__trading__block2').css('border-top', 'none');
    $('.user__product__past').hide();
    $('.user__product__item').show();
  });
});