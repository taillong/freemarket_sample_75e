
$(function(){
  // file_fieldをつける
  function appendFileField(index){
    let html = `<div class="js-file__group" data-index="${index}">
                  <input class="sell-form__image__input__box__field js-file" type="file" name="item[images_attributes][${index}][src]" id="item_images_attributes_${index}_src", accept="image/png,image/jpeg">
                </div>
                `
    $('.sell-form__image__input__box').append(html);
  }
  // プレビューをつける
  function appendPreview(url,index){
    let html = `<div class="previews__preview" data-index="${index}">
                  <p class="previews__preview__photo">
                    <img width="100" height="100" src="${url}">
                  </p>
                  <hr>
                  <div class="previews__preview__btn js-remove">削除</div>
                </div>`
    $('.previews').append(html);
  }

  // 数えるのに必要
  let file_fieldIndex = [1,2,3,4]
  let previewIndex = [0,1,2,3,4]
  let num = 4
  $('.sell-form__image__input__box').on('change', '.js-file',function(){

    // 新しいfile_fieldを加える
    $('.sell-form__image__input__box__text').remove();
    if (file_fieldIndex.length != 0){
      $('.sell-form__image__input__box').attr("for", `item_images_attributes_${file_fieldIndex[0]}_src`);
      appendFileField(file_fieldIndex[0]);
      file_fieldIndex.shift();
    } else {
      $('.sell-form__image__input__box').attr("for", `item_images_attributes_${previewIndex[0] + 1}_src`);
      appendFileField(previewIndex[0] + 1)
      previewIndex.push(previewIndex[0] + 1);
    }
    
    // ファイルのurlを用いてプレビューを追加
    // fileIndexから先頭の数字を削除
    let file = this.files[0];
    let file_reader = new FileReader
    file_reader.readAsDataURL(file);
    file_reader.onload = function(e){
      appendPreview(file_reader.result, previewIndex[0]);
      num += 1
      previewIndex.shift();
      // 五枚目のプレビューを表示する時だけdisplay none
      if ($('.previews__preview').length == 5){
        $('.sell-form__image__input__box').css('display','none');
      }
    }
  })

  // クリックした時削除
  $('.previews').on('click', '.js-remove', function(){
    let index = $(this).parent().attr("data-index");
    if ($('.previews__preview').length == 5){
      $('.sell-form__image__input__box').css('display','block');
    } 
    $(`.previews__preview[data-index=${index}]`).remove();
    $(`.js-file__group[data-index=${index}]`).remove();
    
    file_fieldIndex.push(num)
    previewIndex.push(num)
    num += 1
  })
});