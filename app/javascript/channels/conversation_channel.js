import consumer from "./consumer"

const chatChannel = consumer.subscriptions.create("ConversationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    // log to console if received by back-end
    console.log(data['message']);

    var conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
    // if under the data[‘window’] we pass a partial. If yes, it means that something should be rendered for a recipient. If it’s empty, it means that we should render a code (a message) for a sender.
    if (data['window'] !== undefined) {
      var conversation_visible = conversation.is(':visible');

      // if a conversation’s window is visible
      if (conversation_visible) {
        var messages_visible = (conversation).find('.card-body').is(':visible');
        // minimized
        if (!messages_visible) {
          conversation.removeClass('border-info').addClass('border-success');
        }
        conversation.find('.messages-list').find('ul').append(data['message']);
      }
      else {
        $('#conversations-list').append(data['window']);
        conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
        conversation.find('.card-body').toggle();
      }
    }
    else {
      conversation.find('ul').append(data['message']);
    }

    var messages_list = conversation.find('.messages-list');
    var height = messages_list[0].scrollHeight;
    messages_list.scrollTop(height);
  },

  speak: function(message) {
    return this.perform('speak', {
      message: message
    });
  }
});

$(document).on('submit', '.new_message', function(e) {
  e.preventDefault();
  var values = $(this).serializeArray();
  chatChannel.speak(values);
  $(this).trigger('reset');
});
