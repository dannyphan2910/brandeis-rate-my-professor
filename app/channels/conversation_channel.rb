class ConversationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # create unique channel for each user
    stream_from "conversations-#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # remove all connected connections
    stop_all_streams
  end

  def speak data
    # builds a hash that’s based on a passed data 
    message_params = data['message'].each_with_object({}) do |el, hash|
      hash[el.values.first] = el.values.last
    end

    puts message_params

    Message.create(message_params)
  end
end
