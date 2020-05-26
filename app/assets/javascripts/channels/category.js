// $(function(){
//   // カテゴリーセレクトボックスのオプションを作成
//   function appendOption(category){
//     var html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
//     return html;
//   }
//   // 子カテゴリーの表示作成
//   function appendChidrenBox(insertHTML){
//     var childSelectHtml = '';
//     childSelectHtml = `<div class='listing-select-wrapper__added' id= 'children_wrapper'>
//                         <div class='listing-select-wrapper__box'>
//                           <select class="listing-select-wrapper__box--select" id="child_category" name="category_id">
//                             <option value="---" data-category="---">---</option>
//                             ${insertHTML}
//                           <select>
//                           <i class='fas fa-chevron-down listing-select-wrapper__box--arrow-down'></i>
//                         </div>
//                       </div>`;
//     $('.listing-product-detail__category').append(childSelectHtml);
//   }
//   // 親カテゴリー選択後のイベント
//   $('#parent_category').on('change', function(){
//     var parentCategory = document.getElementById('parent_category').value; //選択された親カテゴリーの名前を取得
//     if (parentCategory != "---"){ //親カテゴリーが初期値でないことを確認
//       $.ajax({
//         url: 'get_category_children',
//         type: 'GET',
//         data: { parent_name: parentCategory },
//         dataType: 'json'
//       })
//       .done(function(children){
//         $('#children_wrapper').remove(); //親が変更された時、子以下を削除するする
//         $('#grandchildren_wrapper').remove();
//         $('#size_wrapper').remove();
//         $('#brand_wrapper').remove();
//         var insertHTML = '';
//         children.forEach(function(child){
//           insertHTML += appendOption(child);
//         });
//         appendChidrenBox(insertHTML);
//       })
//       .fail(function(){
//         alert('カテゴリー取得に失敗しました');
//       })
//     }else{
//       $('#children_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除するする
//       $('#grandchildren_wrapper').remove();
//       $('#size_wrapper').remove();
//       $('#brand_wrapper').remove();
//     }
//   });
// });

$(function(){
  // selectタグに追加する予定のoptionタグを作成
  function appendOption(category){
    let html = `<option value="${category.name}" data-category="${category.id}">
                  ${category.name}
                </option>`;
    return html
  }
  // selectタグを追加
  function appendSelect(insertOption){
    let html = `<select class="sell-form__input--select" id="children_category" name="item[category]">
                  <option value="">選択してください</option>
                  ${insertOption}
                </select>`;
    $('.sell-form__wrapper').append(html);
  }

  //カテゴリーのchangeイベントでajaxが発火する 
  $('#parent_category').on('change', function(){
    let parentCategory = $('#parent_category').val();
    if (parentCategory != ""){
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        data: {parent_name: parentCategory},
        dataType: 'json'
      })
      .done(function(children){
        $('#children_category').remove();
        let insertOption = ``
        children.forEach(function(child){
          insertOption += appendOption(child);
        })
        appendSelect(insertOption);
      })
      .fail(function(){
        alert('カテゴリーの取得に失敗しました');
      })
    } else {
      $('#children_category').remove();
    }
  });
});