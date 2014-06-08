$(document).on("click", "[data-behavior=save-word]", function () {
  var targetWord = event.target.dataset.id;
  var targetContainer = $('[data-container=' + targetWord + ']');
  $(targetContainer).toggleClass('active');
});

$(document).on("ajax:success", "[data-behavior=save-word]", function (event, xhr, status) {
  $(this).append(xhr.responseText);
});