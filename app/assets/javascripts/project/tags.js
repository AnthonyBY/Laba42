$(document).on ('turbolinks:load', function (){
        if(document.getElementById("new_project")!=null){

            let radio_but_project = document.getElementById('radio_but_project');
            let radio_but_test = document.getElementById('test_project_checkbox');
            let currency_block = document.getElementById('currency_block');
            let currency;

            radio_but_project.onclick = function () {
                currency_block.style.display = 'flex';
            };
            radio_but_test.onclick = function () {
                currency_block.style.display = 'none';
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

            (function(){

                var TagsInput = function(opts){
                    this.options = Object.assign(TagsInput.defaults , opts);
                    this.original_input = document.getElementById(opts.selector);
                    this.arr = [];
                    this.wrapper = document.createElement('div');
                    this.input = document.createElement('input');
                    buildUI(this);
                    addEvents(this);
                }


                TagsInput.prototype.addTag = function(string){

                    if(this.anyErrors(string))
                        return ;

                    this.arr.push(string);
                    var tagInput = this;


                    var tag = document.createElement('span');
                    tag.className = this.options.tagClass;
                    tag.innerText = string;

                    var closeIcon = document.createElement('a');
                    closeIcon.innerHTML = '×';
                    closeIcon.addEventListener('click' , function(e){
                        e.preventDefault();
                        var tag = this.parentNode;

                        for(var i =0 ;i < tagInput.wrapper.childNodes.length ; i++){
                            if(tagInput.wrapper.childNodes[i] == tag)
                                tagInput.deleteTag(tag , i);
                        }
                    })


                    tag.appendChild(closeIcon);
                    this.wrapper.insertBefore(tag , this.input);
                    this.original_input.value = this.arr.join(',');

                    return this;
                }



                TagsInput.prototype.deleteTag = function(tag , i){
                    tag.remove();
                    this.arr.splice( i , 1);
                    this.original_input.value =  this.arr.join(',');
                    return this;
                }


                TagsInput.prototype.anyErrors = function(string){
                    if( this.options.max != null && this.arr.length >= this.options.max ){
                        console.log('max tags limit reached');
                        return true;
                    }

                    if(!this.options.duplicate && this.arr.indexOf(string) != -1 ){
                        console.log('duplicate found " '+string+' " ')
                        return true;
                    }

                    return false;
                }


                TagsInput.prototype.addData = function(array){
                    var plugin = this;

                    array.forEach(function(string){
                        plugin.addTag(string);
                    })
                    return this;
                }


                TagsInput.prototype.getInputString = function(){
                    return this.arr.join(',');
                }


                // Private function to initialize the UI Elements
                function buildUI(tags){
                    tags.wrapper.append(tags.input);
                    tags.wrapper.classList.add(tags.options.wrapperClass);
                    tags.original_input.setAttribute('hidden' , 'true');
                    tags.original_input.parentNode.insertBefore(tags.wrapper , tags.original_input);
                }



                function addEvents(tags){
                    tags.wrapper.addEventListener('click' ,function(){
                        tags.input.focus();
                    });
                    tags.input.addEventListener('keydown' , function(e){
                        var str = tags.input.value.trim();
                        if( !!(~[9 , 13 , 188].indexOf( e.keyCode ))  )
                        {
                            tags.input.value = "";
                            if(str != "")
                                tags.addTag(str);
                        }
                    });
                }


                TagsInput.defaults = {
                    selector : '',
                    wrapperClass : 'tags-input-wrapper',
                    tagClass : 'tag',
                    max : null,
                    duplicate: false
                }

                var tagInput = new TagsInput({
                    selector: 'tag-input'
                });

                window.TagsInput = TagsInput;


                $('form').on('keypress', e => {

                    if (e.keyCode == 13) {
                        return false;
                    }
                });
            })();
        }
});
