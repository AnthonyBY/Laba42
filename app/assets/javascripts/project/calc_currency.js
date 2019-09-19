document.addEventListener("turbolinks:load", function(){
    $("#new_project").ready(function() {
        let radio_but_test = document.getElementById('test_project_checkbox');
        let radio_but_project = document.getElementById('radio_but_project');
        let currency_block = document.getElementById('currency_block');
        let currency;

        radio_but_test.onclick = function () {
            currency_block.style.display = 'none';
        };
        radio_but_project.onclick = function () {
            currency_block.style.display = 'flex';
        };

        (function() {
            $.getJSON( "http://www.nbrb.by/api/exrates/rates/145", {}).done(function( data ) {
                currency = data.Cur_OfficialRate;
            });
        })();

        let input = document.getElementById('currency_input');
        let calc_out =  document.getElementById('currency_calc_view');
        input.oninput = function() {
            calc_out.innerHTML = ' ≈ '+ Math.floor(input.value/currency) + ' $';
        };
    });
});
