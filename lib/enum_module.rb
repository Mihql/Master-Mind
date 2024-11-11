module PlayerRole
  PLAYER = :player
  PLAY_MAKER = :playmaker

  def self.role_message(message)
    case status
    when PLAYER
      "You chooce Player"
    when PLAY_MAKER
      "You chooce Playmaker"
    end 
  end
end