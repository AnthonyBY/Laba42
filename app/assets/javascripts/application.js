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
  let eyeClosed = document.querySelector("#eye_closed_pass");

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
    const searchIcon = document.querySelector("#search_icon");
    let query = document.querySelector("#query");

    searchClose.addEventListener("click", function() {
      searchToggle.classList.add("search--disable");
      searchIcon.classList.remove("search--disable");
    });

    searchIcon.addEventListener("click", function() {
      searchToggle.classList.remove("search--disable");
      query.focus();
      this.classList.add("search--disable");
    });
  }

  if (eyeClosed) {
    let eyeOpen = document.querySelector("#eye_open_pass");
    let eyeClosedConfirm = document.querySelector("#eye_closed_pass_confirm");
    let pass = document.querySelector("#pass");

    eyeClosed.addEventListener("click", function() {
      this.classList.add("search--disable");
      eyeOpen.classList.remove("search--disable");
      pass.type = 'text';
    });

    eyeOpen.addEventListener("click", function() {
      this.classList.add("search--disable");
      eyeClosed.classList.remove("search--disable");
      pass.type = 'password';
    });

    if (eyeClosedConfirm) {
      let eyeOpenConfirm = document.querySelector("#eye_open_pass_confirm");
      let passConfirm = document.querySelector("#pass_confirm");

      eyeClosedConfirm.addEventListener("click", function() {
        this.classList.add("search--disable");
        eyeOpenConfirm.classList.remove("search--disable");
        passConfirm.type = 'text';
      });

      eyeOpenConfirm.addEventListener("click", function() {
        this.classList.add("search--disable");
        eyeClosedConfirm.classList.remove("search--disable");
        passConfirm.type = 'password';
      });
    }
  }
});
