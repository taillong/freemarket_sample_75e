$(function(){

  // imageのエラーハンドル
  $('.sell-form__image__input__box').on('click','.js-file',function(){
    // file_fieldが１個しか無いときは、クリックしたら、とりあえずエラーを出しておく
    if ($('.sell-form__image__input__box__field').length == 1) {
      $('.errors--image').css('display','block')
    } 
  });


  // nameのtext_fieldのエラーハンドル
  $('.sell-form__input--text_field--name').on('blur',function(){
    let input = $('.sell-form__input--text_field--name').val();
    if (input == ""){
      $('.sell-form__profile__group--name').find('.errors').remove();
      let html =  `<div class="errors">
                    <p>入力してください</p>
                  </div>`             
      $('.sell-form__profile__group--name').append(html);
    } else {
      $('.sell-form__profile__group--name').find('.errors').remove();
    }
  });

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
  });

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
  });

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
  });

  // 送信時のエラーハンドリング
  $('.sell-form__btn--submit').on('click',function(){
    if($('.sell-form__image__input__box__field').length == 1){
      alert('画像をを入力してください');
      return false;
    }
    if($('.sell-form__input--text_field--name').val() == ''){
      alert('出品名を入力してください');
      $('.sell-form__input--text_field--name').focus();
      return false;
    }
    if($('.sell-form__input--text_area').val() == ''){
      alert('出品の説明を入力してください');
      $('.sell-form__input--text_area').focus();
      return false;
    }
    if($('#parent_category').val() == ''){
      alert('カテゴリーを選択してください');
      $('#parent_category').focus();
      return false;
    }
    if($('#child_category').val() == ''){
      alert('カテゴリーを選択してください');
      $('#child_category').focus();
      return false;
    }
    if($('#grandchild_category').val() == ''){
      alert('カテゴリーを選択してください');
      $('#grandchild_category').focus();
      return false;
    }
    if($('.sell-form__input--select.condition').val() == ''){
      alert('商品の状態を選択してください');
      $('.sell-form__input--select.condition').focus();
      return false;
    }
    if($('.sell-form__input--select.delivery_fee').val() == ''){
      alert('発送の負担を選択してください');
      $('.sell-form__input--select.delivery_fee').focus();
      return false;
    }
    if($('.sell-form__input--select.prefecture').val() == ''){
      alert('発送元の地域を選択してください');
      $('.sell-form__input--select.prefecture').focus();
      return false;
    }
    if($('.sell-form__input--select.duration').val() == ''){
      alert('発送までの日数を選択してください');
      $('.sell-form__input--select.duration').focus();
      return false;
    }
    let price = $('.sell-form__input--price--number_field').val()
    if(price == "" || price < 300 || price > 9999999){
      alert('販売価格を300以上9999999以下で入力してください');
      $('.sell-form__input--price--number_field').focus();
      return false;
    }
  })
});
