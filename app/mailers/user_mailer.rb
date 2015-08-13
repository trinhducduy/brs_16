class UserMailer < ApplicationMailer
  def notify_accept_book_request request
    @request = request
    puts @request.user.email
    mail to: @request.user.email, subject: default_i18n_subject
  end
end
