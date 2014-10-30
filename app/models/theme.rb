class Theme < ActiveRecord::Base
  belongs_to :conference
  has_many :projects
  has_many :discourses, :through => :projects
  has_many :permissions, -> { where(:permissions => { :context_type => 'Theme' }) }, :foreign_key => :context_id

  validates_presence_of :name, :gpo_id

  scope :ordered_by_name, -> { order(:name) }

  alias_attribute :to_s, :name

  def experts
    @experts ||= permissions.map(&:user).compact
  end

  def best_three_with_rate
    discourses.with_rates.group_by(&:average_rate).sort.reverse.first(3)
  end
end
