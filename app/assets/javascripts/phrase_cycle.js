var langua = {};

langua.currentIndex = 0;

langua.showPair = function() {
  var pair = langua.words[langua.wordKey][langua.currentIndex];

  $("[data-container=english-word]").text(pair[0]);
  $("[data-container=portuguese-word]").text(pair[1]);
}

$(document).on("click", "[data-behavior=next-word]", function () {
  langua.currentIndex++;
  if (langua.currentIndex == langua.words[langua.wordKey].length) {
    langua.currentIndex = 0;
  }
  langua.showPair();
});

$(document).on("click", "[data-behavior=last-word]", function () {
  langua.currentIndex--;
  if (langua.currentIndex == -1) {
    langua.currentIndex = langua.words[langua.wordKey].length - 1;
  }
  langua.showPair();
});

$(document).on("click", "[data-behavior=new-category]", function () {
  var targetIndex = langua.categories.indexOf(this.dataset.id);
  langua.wordKey = langua.categories[targetIndex];
  langua.currentIndex = 0;
  $("[data-behavior=new-category]").removeClass('active');
  $(this).addClass('active');
  langua.showPair();
});

$(document).ready(function () {
  $.getJSON('/portuguese/words.json', {category:"All"}, function(data) {
    langua.categories = data.categories;
    langua.wordKey = langua.categories[0];
    langua.words = data.words;
    $('[data-id=' + langua.wordKey + ']').addClass('active');
    langua.showPair();
  });
});