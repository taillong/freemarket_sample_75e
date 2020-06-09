
$(function(){

  // file_fieldをつける
  function appendFileField(index){
    let html = `<div class="js-file__group" data-index="${index}">
                  <input class="sell-form__image__input__box__field js-file" type="file" name="item[images_attributes][${index}][src]" id="item_images_attributes_${index}_src", accept="image/png,image/jpeg">
                </div>
                `
    $('.sell-form__image__input__box').append(html);
  }
  // 新規登録用の画像のプレビューをつける
  function appendPreview(index,url){
    let html = `<div class="previews__preview" data-index="${index}">
                  <img width="100" height="100" src="${url}" ,class="previews__preview__photo">
                  <hr>
                  <div class="previews__preview__btn js-remove">削除</div>
                </div>`
    $('.previews').append(html);
  }

  // file_fieldのnameに動的なindexをつける為の配列
  let file_fieldIndex = [1,2,3,4,5]

  // 既に使われているfile_fieldIndexを除外
  let lastIndex = $('.js-file__group:last').data('index');
  file_fieldIndex.splice(0, lastIndex);
  // $('.hidden-destroy').hide();

  // 新規画像をinputに入れるときに発火
  $('.sell-form__image__input__box').on('change', '.js-file',function(e){

    // $('.sell-form__image__input__box__text').remove();

    // boxのラベルを次のfile_fieldに変更
    $('.sell-form__image__input__box').attr("for", `item_images_attributes_${file_fieldIndex[0]}_src`);
    
    // changeされた選ばれたfile_fieldは何番目か？ 
    const targetIndex = $(this).parent().data('index')
    
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    // 該当indexを持つimgタグがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {  // 新規画像追加の処理
      appendPreview(targetIndex, blobUrl);
      // fileIndexの先頭の数字を使ってinputを作る
      appendFileField(file_fieldIndex[0]);
      file_fieldIndex.shift();
      // 末尾の数に1足した数を追加する
      file_fieldIndex.push(file_fieldIndex[file_fieldIndex.length - 1] + 1);
    }
  });

  // クリックした時削除
  $('.previews').on('click', '.js-remove', function(){
    // クリックしたプレビューは何番目か？
    const targetIndex = $(this).parent().data('index')

    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    // プレビューを削除
    $(this).parent().remove();
    // file_fieldを削除
    $(`.js-file__group[data-index=${targetIndex}]`).remove();

    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) {
      appendFileField(fileIndex[0]);
    }
  })
});