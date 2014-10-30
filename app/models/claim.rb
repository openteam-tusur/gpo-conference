class Claim < ActiveRecord::Base
  belongs_to :conference

  scope :with_pending_state,  ->(state){ where :state => :pending }
  scope :with_approved_state, ->(state){ where :state => :approved }

  def user
    @user ||= User.find_by(:id => user_id)
  end
end
