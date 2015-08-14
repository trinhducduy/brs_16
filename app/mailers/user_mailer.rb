class UserMailer < ApplicationMailer
  def notify_accept_book_request request
    @request = request
    puts @request.user.email
    mail to: @request.user.email, subject: default_i18n_subject
  end

  def notify_review_email user, book, review
    @user = user
    @book = book
    @review = review
    mail to: @user.email, subject: default_i18n_subject(book: @book.title)
  end

  def notify_comment_email user, book, comment
    @user = user
    @book = book
    @comment = comment
    mail to: @user.email, subject: default_i18n_subject(book: @book.title)
  end
end
