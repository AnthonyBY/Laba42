document.addEventListener("turbolinks:load", function(){
    let currency;

    (function() {
        $.getJSON( "http://www.nbrb.by/api/exrates/rates/145", {}).done(function( data ) {
            currency = data.Cur_OfficialRate;
        });
    })();

    $("#new_project").ready(function() {
        let input = document.getElementById('currency_input');
        let calc_out =  document.getElementById('currency_calc_view');
        input.oninput = function() {
            calc_out.innerHTML = ' ≈ '+ Math.floor(input.value/currency) + ' $';
        };
    });
});
