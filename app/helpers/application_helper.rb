module ApplicationHelper
  def full_title page_title
    base_title = t "application.general.title"
    page_title.empty? ? base_title : page_title << " | " << base_title
  end

  def action_type user_book
    if user_book
      user_book.favored? ? Settings.user_books.unfavored : Settings.user_books.favored
    else
      Settings.user_books.favored
    end
  end
end
