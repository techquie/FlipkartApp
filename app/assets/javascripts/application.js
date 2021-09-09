//= require rails-ujs
//= require jquery
//require jquery_ujs
//=require_tree

import { $ } from "@rails/ujs";

$(document).ready(function(){
    $('#updatewalllet').on('click', function(){
        $.ajax({
            url: '/wallets/' + this.parentElement.id,
            type: 'post',
            success: function(res){

            }
        })
    });
});