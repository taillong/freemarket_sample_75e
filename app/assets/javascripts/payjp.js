$(function() {
  Payjp.setPublicKey('pk_test_fc0c1e4803d83a9738994b3e');
  var form = $(".form");
  $(".submit__btn").click(function() {
    form.find("input[type=submit]").prop("disabled", true);
    var card = {
      number: $('#card_number').val(),
      cvc:  $('#cvc').val(),
      exp_month: $("#exp_month").val(),
      exp_year: $('#exp_year').val()
    }
    console.log(card);
    Payjp.createToken(card, function(status, response) {
      if (response.error) {
        alert(response.error.message)
        form.find('.submit__btn').prop('disabled', false);
      }
      else {
        $("#card_number").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name");
        var token = response.id;
        console.log(token)
        // $('.form').append($('<input type="hidden" name="payjpToken" />').val(token));
        $(".form").append(`<input type="hidden" name="payjpToken" class="payjp-token" value=${token} />`)
        form.get(0).submit();
        form.find('.submit__btn').prop('disabled', false);
        // $("#charge-form").append($('<input type="hidden" name="payjp_token" class="payjp-token" />').val(token));
        // $("#charge-form").get(0).submit();
      }
    });
  }) 
});