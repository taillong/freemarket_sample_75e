$(function(){
  // selectタグに追加する予定のoptionタグを作成
  function appendOption(category){
    let html = `<option value="${category.name}" data-category_id="${category.id}">
                  ${category.name}
                </option>`;
    return html
  }
  // 子カテゴリーのselectタグを追加
  function appendSelectChild(insertOption){
    let html = `<select class="sell-form__input--select" id="child_category" name="item[category]">
                  <option value="">選択してください</option>
                  ${insertOption}
                </select>`;
    $('.sell-form__wrapper').append(html);
  }
  
  // 孫カテゴリーのselectタグを追加
  function appendSelectGrandchild(insertOption){
    let html = `<select class="sell-form__input--select" id="grandchild_category" name="item[category]">
                  <option value="">選択してください</option>
                  ${insertOption}
                </select>`;
    $('.sell-form__wrapper').append(html);
  }

  //親カテゴリーのchangeイベントでajaxが発火する 
  $('#parent_category').on('change', function(){
    let parentCategory = $('#parent_category').val();
    // console.log(parentCategory)
    if (parentCategory != ""){
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        data: {parent_name: parentCategory},
        dataType: 'json'
      })
      .done(function(children){
        $('#child_category').remove();
        $('#grandchild_category').remove();
        let insertOption = ``
        children.forEach(function(child){
          insertOption += appendOption(child);
        })
        appendSelectChild(insertOption);
      })
      .fail(function(){
        alert('カテゴリーの取得に失敗しました');
      })
    } else {
      $('#child_category').remove();
      $('#grandchild_category').remove();
    }
  });

  //子カテゴリーのchangeイベントでajaxが発火する 
  $('.sell-form__wrapper').on('change', '#child_category',function(){
    let childId = $('#child_category option:selected').data('category_id');
    // console.log(childId)
    if (childId != null ){
      $.ajax({
        url: 'get_category_grandchildren',
        type: 'GET',
        data: {child_id: childId},
        dataType: 'json'
      })
      .done(function(grandchildren){
        $('#grandchild_category').remove();
        let insertOption = ``
        grandchildren.forEach(function(grandchild){
          insertOption += appendOption(grandchild);
        })
        appendSelectGrandchild(insertOption);
      })
      .fail(function(){
        alert('カテゴリーの取得に失敗しました');
      })
    } else {
      $('#grandchild_category').remove();
    }
  });
});