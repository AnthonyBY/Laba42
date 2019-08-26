

// redAlert = function() {
//       $( "#goodnote" ).addClass( "d-none" );
//       $( "#hintalert" ).addClass( "d-none" );
//       $( "#badnote" ).removeClass( "d-none" );
//       $( "#user_email" ).removeClass( "greenalert hintalert onblur");
//       $( "#user_email" ).addClass( "redalert");
//       switchbutton.setAttribute("disabled", true);
//       $( "#switchbutton" ).addClass( "notallowed");
//     },
//     greenAlert = function() {
//       $( "#badnote" ).addClass( "d-none" );
//       $( "#hintalert" ).addClass( "d-none" );
//       $( "#goodnote" ).removeClass( "d-none" );
//       $( "#user_email" ).removeClass( "redalert hintalert onblur");
//       $( "#user_email" ).addClass( "greenalert" );
//       switchbutton.removeAttribute("disabled", true);
//       $( "#switchbutton" ).addClass( "pointer");
//     },
//     hintAlert = function() {
//       $( "#badnote" ).addClass( "d-none" );
//       $( "#goodnote" ).addClass( "d-none" );
//       $( "#hintalert" ).removeClass( "d-none" );
//       $( "#user_email" ).removeClass( "redalert greenalert onblur");
//       $( "#user_email" ).addClass( "hintalert" );
//       switchbutton.setAttribute("disabled", true);
//       $( "#switchbutton" ).addClass( "notallowed");
//     };

const userEmail = document.querySelector("#user_email");

if (userEmail) {

  const hintNote = document.querySelector("#hintNote"),
        badNote = document.querySelector("#goodNote"),
        goodNote = document.querySelector("#badNote"),

        regExpEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/,

        hintAlert = () => {
          hintNote.classList.remove("form-field--hide");
          badNote.classList.add("form-field--hide");
          goodNote.classList.add("form-field--hide");
        },

        badAlert = () => {
          goodNote.classList.remove("form-field--hide");
          hintNote.classList.add("form-field--hide");
          badNote.classList.add("form-field--hide");
        },

        goodAlert = () => {
          badNote.classList.remove("form-field--hide");
          hintNote.classList.add("form-field--hide");
          goodNote.classList.add("form-field--hide");
        };

  userEmail.addEventListener( "keyup", function() {

    if ( regExpEmail.test( userEmail.value )) {
      const xmlhttp = new XMLHttpRequest();

      xmlhttp.onreadystatechange = function() {
       if (xmlhttp.readyState == 4 && xmlhttp.status == 302) {
          badAlert();

        } else if (xmlhttp.readyState == 4 && xmlhttp.status == 204) {
          goodAlert();
        }
      }
      xmlhttp.open("GET", "/uniqness/" + userEmail.value, true);
      xmlhttp.send();
    } else {
      hintAlert();
    }
  });
}
