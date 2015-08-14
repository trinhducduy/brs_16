$("#relationship_<%= @user.id %>").html('<%= escape_javascript(render("users/relationship_form",
  user: @user)) %>');
