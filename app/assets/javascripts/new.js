$(function(){
  function addHTML(name) {
    var html = `<div class="field__error" id="${name}">
                  <p>${name}を入力してください</p>
                </div>`
    return html
  }

  function addEmail(name, text) {
    var html = `<div class="field__error" id="${name}">
                  ${text}
                </div>`
    return html
  }

  $('.field__input__defalut').on('focusout', function(e) {
    e.preventDefault();
    var input = $(this).val()
    var name = $(this).data("name");
    if (input != "") {
      $(`#${name}`).remove();
      if (name == "メールアドレス" && input.match(/.+@.+/)) {
        $(`#${name}`).remove();
      }else if (name === "パスワード" && input.match(/^(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,}$/i)) {
        $(`#${name}`).remove();
      }else if (name === "確認用のパスワード" && input.match(/^(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,}$/i)) {
        $(`#${name}`).remove();
        var password = $('#field__input__password').val()
        if (password != input) {
          var html = addEmail(name, "値が一致しません")
          $(this).parent().append(html)
        }
      }else if (name == "郵便番号" && input.match(/[0-9]{3}-[0-9]{4}/)) {
        $(`#${name}`).remove();
      }else {
        $(`#${name}`).remove();
        if (name == "メールアドレス") {
          var html = addEmail(name, "フォーマットが異なります")
          $(this).parent().append(html)
        } else if (name === "パスワード") {
          var html = addEmail(name, "半角英数字7文字以上にしてください")
          $(this).parent().append(html)
        } else if (name === "確認用のパスワード") {
          var html = addEmail(name, "半角英数字7文字以上にしてください")
          $(this).parent().append(html)
        } else if (name === "郵便番号") {
          var html = addEmail(name, "フォーマットが異なります")
          $(this).parent().append(html)
        }
      };
    }
    else {
      $(`#${name}`).remove();
      console.log("ok");
      var html = addHTML(name)
      $(this).parent().append(html)
    }
  });

  $('input[type="checkbox"]').on('change', function() {
    console.log('ok')
    var password = $('#field__input__password').val()
    var prop = $('#test1').prop('checked')
    console.log(prop)
    if (prop) {
      $('.field__checkbox').append(`<div class="checkbox__confirmation">${password}</div>`)
    }else {
      $('.checkbox__confirmation').remove()
    }
  })


  $('.field__input__ecality').on('focusout', function(e) {
    e.preventDefault();
    var input = $(this).val()
    var name = $(this).data("name");
    console.log(name);
    if (input != "") {
      $(`#${name}`).remove();
      if ((name == "性" || name == "名") && input == input.match(/[一-龥ぁ-ん]+/)) {
        console.log(input.match(/[一-龥ぁ-ん]+/))
        $(`#${name}`).remove();
      } else if ((name == "性かな" || name == "名かな") && input == input.match(/[ぁ-んー－]+/)) {
        $(`#${name}`).remove();
      } else {
        $(`#${name}`).remove();
        if (name == "性" || name == "名") {
          var html = addEmail(name, "全角で入力してください")
          $(this).parent().append(html)
        }else if(name == "性かな" || name == "名かな") {
          var html = addEmail(name, "全角かなで入力してください")
          $(this).parent().append(html)
        }
      }
    } else {
      $(`#${name}`).remove();
      var html = addHTML(name)
      $(this).parent().append(html)
    }
  });
});

  // else if (name === "性") {
  //   var html = addEmail(name, "全角で入力してください")
  //   $(this).parent().append(html) 
  // }

  // $('.field__input__defalut').on('focusout', function(e) {
  //   e.preventDefault();
  //   var input = $(this).val()
  //   var name = $(this).attr('name');
  //   console.log()
  //   if (input === "") {
  //     $(`#${name}`).remove();
  //     var html = addHTML(name)
  //     $(this).parent().append(html)
  //   }
  //   else {
  //     $(`#${name}`).remove();
  //   }
  // });

  // $('#field__input__email').on('focusout', function(e) {
  //   e.preventDefault();
  //   var input = $(this).val()
  //   var name = $(this).attr('name');
  //   console.log(input.match(/.+@.+/));
  //   if (input.match(/.+@.+/)) {
  //     console.log("ok");
  //     $(`#${name}`).remove();
  //   }else {
  //     $(`#${name}`).remove();
  //     var html = addEmail(name)
  //     $(this).parent().append(html)
  //   }
  // });

  // $('#field__input__password').on('focusout', function(e) {
  //   e.preventDefault();
  //   var input = $(this).val()
  //   var name = $(this).attr('name');
  //   console.log(input.match(/^(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,}$/i));
  //   if (input.match(/^(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,}$/i)) {
  //     console.log("ok");
  //     $(`#${name}`).remove();
  //   }else {
  //     $(`#${name}`).remove();
  //     var html = addPassword(name)
  //     $(this).parent().append(html)
  //   }
  // });

  // $('#field__input__password_confirmation').on('focusout', function(e) {
  //   e.preventDefault();
  //   var password = $('#field__input__password').val()
  //   var input = $(this).val()
  //   console.log(password)
  //   var name = $(this).attr('name');
  //   console.log(input.match(/^(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,}$/i));
  //   if (input.match(/^(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,}$/i)) {
  //     $(`#${name}`).remove();
  //     if (password != input) {
  //       $(`#${name}`).remove();
  //       var html = addDisgrement(name)
  //       $(this).parent().append(html)
  //     }
  //   }else {
  //     $(`#${name}`).remove();
  //     var html = addPassword(name)
  //     $(this).parent().append(html)
  //   }
  // });

  