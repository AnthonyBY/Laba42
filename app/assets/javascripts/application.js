// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

document.addEventListener("turbolinks:load", function(){
  const userEmail = document.querySelector("#email_check");
  const searchClose = document.querySelector("#search_close");

  if (userEmail) {

    const badNote = document.querySelector("#good_note");
    const goodNote = document.querySelector("#bad_note");
    const regSubmit = document.querySelector("#reg_submit");

    const regExpEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

    const badAlert = () => {
            goodNote.classList.remove("form-field--hide");
            badNote.classList.add("form-field--hide");
            regSubmit.setAttribute("disabled", true);
            regSubmit.classList.add("not-allowed");
          };

    const goodAlert = () => {
            badNote.classList.remove("form-field--hide");
            goodNote.classList.add("form-field--hide");
            regSubmit.removeAttribute("disabled", true);
            regSubmit.classList.remove("not-allowed");
          };

    const cleanAlert = () => {
            badNote.classList.add("form-field--hide");
            goodNote.classList.add("form-field--hide");
            regSubmit.setAttribute("disabled", true);
            regSubmit.classList.add("not-allowed");
          };

    userEmail.addEventListener("keyup", function() {

      if (regExpEmail.test(userEmail.value )) {

        $.ajax({
          url: "/users/email_exists",
          method: "POST",
          data: {email: userEmail.value},
          success: function(data){
            if (data.exists) {
              badAlert();
            } else {
              goodAlert();
            }
          }
        });
      } else {
        cleanAlert();
      }
    });
  }

  if (searchClose) {
    const searchToggle = document.querySelector("#search_toggle");
    const searchImg = document.querySelector("#search_img");

    searchClose.addEventListener("click", function() {
      searchToggle.classList.add("search--disable");
      searchImg.classList.remove("search--disable");
    });

    searchImg.addEventListener("click", function() {
      searchToggle.classList.remove("search--disable");
      this.classList.add("search--disable");
    });
  }
});
