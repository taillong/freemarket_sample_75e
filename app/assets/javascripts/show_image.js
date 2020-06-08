$(function(){
  $('.image__list').on('click', function(e){
    e.preventDefault()
    var $src = $(this).attr('src');
    $('.main__image').attr('src', $src);
  })
})