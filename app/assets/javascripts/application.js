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
//= require flip/dist/jquery.flip
//= require_tree .

$(document).on("page:change", function(){
  $("#datepicker").datepicker({dateFormat: "yy-mm-dd"});
  $(".book-item .flip").flip({trigger: "hover", speed: 700});

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
      } else {
        var errors = getFormErrors(response.data);
        modal.find(".modal-body > .errors").empty().prepend(errors);
      }
    }, "json");
  });

  $(".form-group input[type='file']").change(function(event) {
    var preview = $("#preview_cover");
    var input = $(event.currentTarget);
    var file = input[0].files[0];
    var reader = new FileReader();

    reader.onload = function(e) {
      image_base64 = e.target.result;
      preview.attr("src", image_base64);
    };
    reader.readAsDataURL(file);
  });

  $(".book-detail").on("click", ".book-marker, .btn-favorites, .tick", function(e){
    e.preventDefault();
    var actionType = $(this).data("action");
    var url = $(this).attr("href");
    $.post(url, {action_type: actionType}, function(response){
      if (response.status == "success") {
        updateUserBook(response.data)
      } else {
        var message = getFlashMessage(response.message, "danger");
        $("#flash").append(message);
      }
    }, "json");
  });
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

function updateUserBook(userBook) {
  var container = $(".book-detail");
  var status = $(".book-detail").find(".current-status");
  var favorites = $(".book-detail").find(".favorites > .btn");
  var tick = "<i class='glyphicon glyphicon-ok tick'></i>";

  if (userBook.status != "not_read") {
    status.empty().html(tick + " " + userBook.status.charAt(0).toUpperCase()
      + userBook.status.slice(1));
  }

  $(".book-marker[data-action='mark_" + userBook.status + "']").parent()
    .addClass("hide").siblings().removeClass("hide");

  if (userBook.favored) {
    favorites.removeClass("add_to_favorites").addClass("remove_from_favorites")
      .text(favorites.data("unfavored"));
    favorites.data("action", "remove_from_favorites");
    favorites.find(".glyphicon").removeClass("glyphicon-plus").addClass("glyphicon-minus");
  } else {
    favorites.removeClass("remove_from_favorites").addClass("add_to_favorites")
      .text(favorites.data("favored"));
    favorites.data("action", "add_to_favorites");
    favorites.find(".glyphicon").removeClass("glyphicon-minus").addClass("glyphicon-plus");
  }
}
