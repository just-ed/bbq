class CommentAddedJob < ApplicationJob
  queue_as :default

    def perform(event, model)
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [model.user.email]).uniq

    all_emails.each { |mail| EventMailer.comment(event, model, mail).deliver_later }
  end
end
