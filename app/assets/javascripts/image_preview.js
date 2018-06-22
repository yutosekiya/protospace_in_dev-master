// turbolinks対応
$(document).on('turbolinks:load', function () {

  // サムネイル画像のプレビュー
  $('[id^=prototype_captured_images_attributes]').on('change', function () {

    if ($(this)[0].files.length) {
      var file = $(this).prop('files')[0];
      var reader = new FileReader();
      var preview_area = $(this).siblings('img');

      reader.onload = function () {
        preview_area.attr('src', reader.result);
      };

      reader.readAsDataURL(file);
    }
  });
});
