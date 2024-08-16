class TeamMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  def lead?
    is_lead == 1
  end

  def make_lead
    update(is_lead: 1)
  end

  def remove_lead
    update(is_lead: 0)
  end
end
  