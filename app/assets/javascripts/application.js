// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootsy
//= require turbolinks
//= require bootstrap-sprockets
//= require jquery-ui/datepicker
//= require_tree .

$(document).on("page:change", function(){
  $("#datepicker").datepicker({dateFormat: "yy-mm-dd"});

  $("#requestBook").on("click", function(e){
    e.preventDefault();
    var modal = $("#brsModal");
    var modalTitle = $(this).data("modalTitle");
    var url = $(this).attr("href");

    modal.find(".modal-title").text(modalTitle);

    $.get(url, {}).done(function(data) {
      modal.find(".modal-body > .errors").empty();
      modal.find(".modal-body > .content").empty().html(data);
    });

    modal.modal("show");
  });

  $("#brsModal").on("submit", "#new_request", function(e){
    e.preventDefault();
    var url = $(this).attr("action");
    var data = $(this).serialize();
    var modal = $("#brsModal");

    $.post(url, data, function(response){
      if (response.status == "success") {
        modal.modal("hide");
        var message = getFlashMessage(response.message, "success");
        $("#flash").append(message);
      }
      else {
        var errors = getFormErrors(response.data);
        modal.find(".modal-body > .errors").empty().prepend(errors);
      }
    }, "json");
  })
});

function getFlashMessage(content, type){
  return "<div class='alert alert-" + type + "'><a href='#' data-dismiss='alert'\
    class='close'>x</a><ul><li>" + content + "</li></ul></div>";
}

function getFormErrors(errors) {
  var wrapper = $("<ul class='alert alert-warning'></ul>");
  for (i in errors) {
    wrapper.append("<li>" + errors[i] + "</li>");
  }
  return wrapper;
}
