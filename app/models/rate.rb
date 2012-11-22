class Rate < ActiveRecord::Base
  belongs_to :user
  belongs_to :discourse
  attr_accessible :urgency, :practicality, :novelty, :typography
  validates :urgency, :practicality, :novelty, :typography, presence: true,
                                                            numericality: { only_integer: true },
                                                            inclusion: {in: 1..10}
  before_save :set_cached_total

  scope :rated_by, ->(user) { where(:user_id => user) }

  def total
    cached_total || calculated_total
  end

  private

  def calculated_total
    0.3*urgency + 0.3*practicality + 0.3*novelty + 0.1*typography
  end

  def set_cached_total
    self.cached_total = calculated_total
  end
end
