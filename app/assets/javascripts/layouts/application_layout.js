document.addEventListener("turbolinks:load", function(){
  $(document.body).ready(function() {
    const searchIcon = $("#search_icon");

    function flip(clickElem, addElem, removeElem, ...args) {
      clickElem.on("click", function() {
        addElem.addClass("search--disable");
        removeElem.removeClass("search--disable");

        if (args[0]) {
          args[0].focus();
        }
      });
    }

    if (searchIcon) {
      const searchToggle = $("#search_toggle");
      const searchClose = $("#search_close");
      const query = $("#query");

      flip(searchClose, searchToggle, searchIcon);
      flip(searchIcon, searchIcon, searchToggle, query);
    }
  });
});
