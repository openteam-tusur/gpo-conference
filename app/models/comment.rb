class Comment < ActiveRecord::Base
  has_ancestry

  belongs_to :discourse

  normalize_attribute :body, :ancestry
  validates_presence_of :body

  delegate :name, :to => :user, :prefix => true

  def user
    @user ||= User.find_by(:id => user_id)
  end
end
