class TeamService
  def list
    Team.order('team_name DESC')
  end
end