module GaminpadAuthHelpers
  
  def current_player
    current_player ||= Player.token_authorize(headers['Authorization-Token'])
  end
  
  def authenticate_player!
    current_player = Player.authenticate_with_email(params[:email], params[:password])
    if current_player
      current_player.update_tracked_fields!(request)
      return current_player
    else
      error!('Unauthorized Request: Wrong email/password', 401)
    end
  end
  
  def verify_token
    error!('Unauthorized Request: Token invalid', 401) unless current_player
  end
  
end