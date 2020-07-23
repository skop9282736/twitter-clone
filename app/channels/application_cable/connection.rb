module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # connection identifier that can be used to find the specific connection later.
    identified_by :current_user

    def connect
      self.current_user = current_user #using devise is simple :)
    end

    '''
      - a successful authentication sets a signed cookie with the user ID.
      - The cookie is then automatically sent to the connection instance when a 
        new connection is attempted, and you use that to set the current_user. By 
        identifying the connection by this same current user, you`re also ensuring 
        that you can later retrieve all open connections by a given user (and potentially 
        disconnect them all if the user is deleted or unauthorized).
    '''

    private
    # this is working only without devise
    def find_verified_user
      if verified_user = User.find_by(id: cookies.encrypted[:user_id])
        verified_user
      else
        reject_unauthorized_connection
      end
    end

  end
end
