(function(){
  const userEmail = document.querySelector("#user_email");

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
})();
