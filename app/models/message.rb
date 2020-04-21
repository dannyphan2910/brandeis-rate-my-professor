class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  # executes a code or a method passed in params when a record has been created and successfully inserted to a database – when SQL commit is done
  after_create_commit { MessageBroadcastJob.perform_later(self) }
end
