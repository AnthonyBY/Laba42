document.addEventListener("turbolinks:load", function(){
  $("#signup").ready(function() {
    const userEmail = $("#email_check");
    const eyeClosed = $("#eye_closed_pass");
    const eyeOpened = $("#eye_open_pass");
    const eyeClosedConfirm = $("#eye_closed_pass_confirm");
    const eyeOpenConfirm = $("#eye_open_pass_confirm");
    const badNote = $("#good_note");
    const goodNote = $("#bad_note");
    const regSubmit = $("#reg_submit");
    const pass = $("#pass");
    const passConfirm = $("#pass_confirm");
    const regExpEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

    const badAlert = () => {
            goodNote.removeClass("form-field--hide");
            badNote.addClass("form-field--hide");
            regSubmit.attr("disabled");
            regSubmit.addClass("not-allowed");
          };

    const goodAlert = () => {
            badNote.removeClass("form-field--hide");
            goodNote.addClass("form-field--hide");
            regSubmit.removeAttr("disabled");
            regSubmit.removeClass("not-allowed");
          };

    const cleanAlert = () => {
            badNote.addClass("form-field--hide");
            goodNote.addClass("form-field--hide");
            regSubmit.attr("disabled");
            regSubmit.addClass("not-allowed");
          };

    function flip(clickElem, addElem, removeElem) {
      clickElem.on("click", function() {
        addElem.addClass("search--disable");
        removeElem.removeClass("search--disable");
      });
    }

    flip(eyeClosed, eyeClosed, eyeOpened);
    flip(eyeOpened, eyeOpened, eyeClosed);
    flip(eyeClosedConfirm, eyeClosedConfirm, eyeOpenConfirm, passConfirm.attr("type","text"));
    flip(eyeOpenConfirm, eyeOpenConfirm, eyeClosedConfirm);

    userEmail.keyup(function() {
      if (regExpEmail.test(userEmail.val())) {
        $.ajax({
          url: "/users/email_exists",
          method: "POST",
          data: {email: userEmail.val()},
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
  });
});
