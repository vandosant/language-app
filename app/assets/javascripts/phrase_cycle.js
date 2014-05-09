var currentIndex = 0;

$(document).on("click", "[data-behavior=next-word]", function () {
  var pair = words[currentIndex];

  $("[data-container=english-word]").text(pair[0]);
  $("[data-container=portuguese-word]").text(pair[1]);

  currentIndex++;
  if(currentIndex == words.length) {
    currentIndex = 0;
  }
});