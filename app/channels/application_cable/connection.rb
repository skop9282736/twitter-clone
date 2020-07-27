module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # connection identifier that can be used to find the specific connection later.
    identified_by :current_user

    def connect
      user_id = cookies.encrypted[:user_id]
      return reject_unauthorized_connection if user_id.nil?
      user = User.find_by(id: user_id)
      return reject_unauthorized_connection if user.nil?
      self.current_user = user
    end

  end
end
