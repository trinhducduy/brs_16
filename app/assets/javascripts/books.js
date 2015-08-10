$(document).on("page:change", function(){
  $("form").on("click", ".remove_fields", function(e) {
    e.preventDefault();
    $(this).closest(".field").remove();
  });

  $("form").on("click", ".add_fields", function(e) {
    var regexp, time;

    e.preventDefault();
    time = new Date().getTime();
    regexp = new RegExp($(this).data("id"), "g");
    $(this).before($(this).data("fields").replace(regexp, time));
  });

  $("#advancedSearchToggle").on("click", function(e){
    e.preventDefault();
    $(this).find("i").toggleClass("glyphicon-plus-sign glyphicon-minus-sign");
    $(this).find(".text").toggleClass("hide");
    $("#advancedSearch").toggleClass("hide");
  })
});
