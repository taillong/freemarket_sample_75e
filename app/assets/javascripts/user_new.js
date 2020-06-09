$(function(){
  // エラーメッセージ
  function addHTML(name, place) {
    var html = `<div class="field__error" id="${name}">
                  <p>${name}を入力してください</p>
                </div>`
    $(`#${name}`).remove();
    $(place).parent().append(html)
  }

  function addEmail(name, text, place) {
    var html = `<div class="field__error" id="${name}">
                  ${text}
                </div>`
    $(`#${name}`).remove();
    $(place).parent().append(html)
  }

  // class: "field__input__defalut"を入力した場合のバリデーションチッエック
  function value(input, name, place) {
    if (input != "") {
      $(`#${name}`).remove();
      if (name == "メールアドレス" && input.match(/^[a-zA-Z0-9_#!$%&`'*+-{|}~^\/=?.]+@[a-zA-Z0-9][a-zA-Z0-9.-]+$/)) {
        $(`#${name}`).remove();
      }else if (name === "パスワード" && input.match(/^(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,}$/i)) {
        $(`#${name}`).remove();
      }else if (name === "確認用のパスワード" && input.match(/^(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,}$/)) {
        $(`#${name}`).remove();
        var password = $('#field__input__password').val()
        if (password != input) {
          addEmail(name, "値が一致しません", place)
        }
      }else if (name == "郵便番号" && input.match(/[0-9]{3}-[0-9]{4}/)) {
        $(`#${name}`).remove();
      }else {
        $(`#${name}`).remove();
        if (name == "メールアドレス") {
          addEmail(name, "フォーマットが異なります", place)
        } else if (name === "パスワード") {
          addEmail(name, "半角英数字7文字以上にしてください", place)
        } else if (name === "確認用のパスワード") {
          addEmail(name, "半角英数字7文字以上にしてください", place)
        } else if (name === "郵便番号") {
          addEmail(name, "フォーマットが異なります", place)
        } 
      };
    }
    else {
      addHTML(name, place)
    }
  }

  // class: "field__input__ecality"を入力した場合のバリデーションチッエック
  function person(input, name, place) {
    if (input != "") {
      $(`#${name}`).remove();
      if ((name == "性" || name == "名") && input == input.match(/[一-龥ぁ-ん]+/)) {
        $(`#${name}`).remove();
      } else if ((name == "性かな" || name == "名かな") && input == input.match(/[ぁ-んー－]+/)) {
        $(`#${name}`).remove();
      } else {
        $(`#${name}`).remove();
        if (name == "性" || name == "名") {
          addEmail(name, "全角で入力してください", place)
        }else if(name == "性かな" || name == "名かな") {
          addEmail(name, "全角かなで入力してください", place)
        }
      }
    } else {
      var html = addHTML(name, place)
    }
  }

  // 電話番号バリデーションチェック
  function tell_error(input, name, place) {
    if (name === "電話番号" && input.match(/^[0-9]+$/)) {
      $(`#${name}`).remove();
    } else if(input == "") {
      $(`#${name}`).remove();
    } else {
      addEmail(name, "フォーマットが異なります", place)
    }
  }
  
  // class: "field__input__defalut"を入力した場合
  $('.field__input__defalut').on('focusout', function(e) {
    e.preventDefault();
    var input = $(this).val()
    var name = $(this).data("name");
    value(input, name, this);
  });

  // class: "field__input__ecality"を入力した場合
  $('.field__input__ecality').on('focusout', function(e) {
    e.preventDefault();
    var input = $(this).val()
    var name = $(this).data("name");
    person(input, name, this);
  });

   // class: "field__input__ecality"を入力した場合
   $('.field__input__defalut__none').on('focusout', function() {
    var input = $(this).val()
    var name = $(this).data("name");
    tell_error(input, name, this);
  });

  // 誕生日バリデーション未実装
  // $('#person_info_birth_date_1i, #person_info_birth_date_2i, #person_info_birth_date_3i').on('focusout', function() {
  //   var input = $(this).val()
  //   console.log(input)
  //   if (input == input.match(/[0-9]{1,4}/)) {
  //     var m = $('this option[value=input]').prop('selected', true)
  //     // var m = $('this option[value=input]').val()
  //     console.log(m)
  //     var num = $('select :selected').length
  //     if ($('select :selected').length == 3) {
  //       console.log(num)
  //       $(`#数字`).remove();
  //     }
  //   } else {
  //     var m = $(this).attr('selected', false)
  //     console.log(m)
  //     addHTML("数字",this);
  //   }
  // });
  
  //  パスワード確認
  $('input[type="checkbox"]').on('change', function() {
    var password = $('#field__input__password').val()
    var prop = $('#test1').prop('checked')
    if (prop) {
      $('.field__checkbox').append(`<div class="checkbox__confirmation">${password}</div>`)
    }else {
      $('.checkbox__confirmation').remove()
    }
  });

  //  user登録確認
  $('#new_user').on('submit', function() {
    $('.field__input__defalut').each(function() { 
      value($(this).val(), $(this).data("name"), $(this));
    });
    $('.field__input__ecality').each(function() { 
      person($(this).val(), $(this).data("name"), $(this));
    });
    if ($('.field__error').length > 0 ) {
      return false;
    }
  });

  //  address登録確認
  $('#new_address').on('submit', function() {
    $('.field__input__defalut').each(function() { 
      value($(this).val(), $(this).data("name"), $(this));
    });
    $('.field__input__ecality').each(function() { 
      person($(this).val(), $(this).data("name"), $(this));
    });
    $('.field__input__defalut__none').each(function() { 
      tell_error($(this).val(), $(this).data("name"), $(this));
    });
    if ($('.field__error').length > 0 ) {
      return false;
    }
  });

  //  person_info登録確認
  $('#new_person_info').on('submit', function() {
    $('.field__input__defalut').each(function() { 
      value($(this).val(), $(this).data("name"), $(this));
    });
    $('.field__input__ecality').each(function() { 
      person($(this).val(), $(this).data("name"), $(this));
    });
    if ($('.field__error').length > 0 ) {
      return false;
    }
  });
});