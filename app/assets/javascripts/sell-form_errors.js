$(function(){

  // nameのtext_fieldのエラーハンドル
  $('.sell-form__input--text_field--name').on('blur',function(){
    let input = $('.sell-form__input--text_field--name').val();
    console.log($(this).parent())
    if (input == ""){
      $('.sell-form__profile__group--name').find('.errors').remove();
      let html =  `<div class="errors">
                    <p>入力してください</p>
                  </div>`             
      $('.sell-form__profile__group--name').append(html);
    } else {
      $('.sell-form__profile__group--name').find('.errors').remove();
    }
  })

  // text_areaのエラーハンドル
  $('.sell-form__input--text_area').on('blur',function(){
    let input = $(this).val();
    if (input == ""){
      $(this).parent().find('.errors').remove();
      let html =  `<div class="errors">
                    <p>入力してください</p>
                  </div>`             
      $(this).parent().append(html);
    } else {
      $(this).parent().find('.errors').remove();
    }
  })

  // selectのエラーハンドル
  $('.sell-form__input--select').on('blur',function(){
    let input = $(this).val();
    if (input == ""){
      $(this).parent().find('.errors').remove();
      let html =  `<div class="errors">
                    <p>選択してください</p>
                  </div>`             
      $(this).parent().append(html);
    } else {
      $(this).parent().find('.errors').remove();
    }
  })

  // priceのエラーハンドル
  $('.sell-form__input--price--number_field').on('blur',function(){
    let input = $(this).val();
    if (input == "" || input < 300 || input > 9999999){
      $('.sell-form__content--price__group__wrapper').find('.errors--price').remove();
      let html =  `<div class="errors--price">
                    <p>300以上9999999以下で入力してください</p>
                  </div>`             
      $('.sell-form__content--price__group__wrapper').append(html);
    } else {
      $('.sell-form__content--price__group__wrapper').find('.errors--price').remove();
    }
  })
});
