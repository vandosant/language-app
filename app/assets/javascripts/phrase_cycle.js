var langua = {};

langua.currentIndex = 0;

langua.showPair = function() {
  var pair = langua.words[langua.currentIndex];

  $("[data-container=english-word]").text(pair[0]);
  $("[data-container=portuguese-word]").text(pair[1]);
}

$(document).on("click", "[data-behavior=next-word]", function () {
  langua.currentIndex++;
  if (langua.currentIndex == langua.words.length) {
    langua.currentIndex = 0;
  }
  langua.showPair();
});

$(document).on("click", "[data-behavior=last-word]", function () {
  langua.currentIndex--;
  if (langua.currentIndex == -1) {
    langua.currentIndex = langua.words.length - 1;
  }
  langua.showPair();
});

$(document).ready(function () {
  $.getJSON('/portuguese/words.json', {category:"All"}, function(data) {
    langua.words = data;
    langua.showPair();
  });
});