document.addEventListener("turbolinks:load", function(){
  $("#login").ready(function() {
    const eyeClosed = $("#eye_closed_pass");
    const eyeOpened = $("#eye_open_pass");
    const pass = $("#pass");

    function flip(clickElem, addElem, removeElem, param) {
      clickElem.on("click", function() {
        addElem.addClass("search--disable");
        removeElem.removeClass("search--disable");
        pass.attr("type", param);
      });
    }

    flip(eyeClosed, eyeClosed, eyeOpened, "text");
    flip(eyeOpened, eyeOpened, eyeClosed, "password");
  });
});
