// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require('jquery')
require("jquery-ui")
require("jquery-bar-rating")
require('js-autocomplete')


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "bootstrap";
import "../stylesheets/application";
import "@fortawesome/fontawesome-free/js/all";

$(function () {
    $('[data-toggle="tooltip"]').tooltip()
})

$(function () {
    $('[data-toggle="dropdown"]').dropdown()
})

$(function() {
    $('[data-toggle="popover"]').popover();
});

$(function() {
    $('[data-toggle="collapse"]').collapse();
});

$(function() {
    var availableTags = [
        "ActionScript",
        "AppleScript",
        "Asp",
        "BASIC",
        "C",
        "C++",
        "Clojure",
        "COBOL",
        "ColdFusion",
        "Erlang",
        "Fortran",
        "Groovy",
        "Haskell",
        "Java",
        "JavaScript",
        "Lisp",
        "Perl",
        "PHP",
        "Python",
        "Ruby",
        "Scala",
        "Scheme"
      ];
    $('#term').autocomplete({
        source: availableTags
    });
});

$(document).on('turbolinks:load',function(){
    $("select#review_course_id").on("change", function(){
        $.ajax({
            url: "/filter_professor_by_course",
            type: "GET",
            data: {gcname: $("select#review_course_id").val(), year: $("select#review_course_year").val()}
        });
    });
});
  
  $(document).on('turbolinks:load',function(){
    $("select#review_course_year").on("change",function(){
      $.ajax({
        url: "/filter_course_by_year",
        type: "GET",
        data: {year: $("select#review_course_year").val()}
      });
    });
  });

  