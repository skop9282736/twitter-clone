module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # connection identifier that can be used to find the specific connection later.
    identified_by :current_user

    def connect
      self.current_user = current_user #using devise is simple :)
    end

  end
end
