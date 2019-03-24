class EventMailer < ApplicationMailer

  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    mail to: event.user.email, subject: "Новая подписка на #{event.title}"
  end

  def comment(event, comment, email)
    @event = event
    @comment = comment

    mail to: email, subject: "Новый комментарий к событию #{event.title}"
  end

  def photo(event, photo, email)
    @event = event
    @photo = photo

    mail to: email, subject: "Новая фотография к событию #{event.title}"
  end
end
