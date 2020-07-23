module ApplicationCable
  class Channel < ActionCable::Channel::Base
    # Called when the consumer has successfully
    # become a subscriber to this channel.
    def subscribed
    end
  end
end
