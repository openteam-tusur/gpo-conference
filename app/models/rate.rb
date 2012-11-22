class Rate < ActiveRecord::Base
  belongs_to :user
  belongs_to :discourse
  attr_accessible :urgency, :practicality, :novelty, :typography
  validates_presence_of :urgency, :practicality, :novelty, :typography
  before_save :set_cached_total

  default_value_for :urgency,       0
  default_value_for :practicality,  0
  default_value_for :novelty,       0
  default_value_for :typography,    0

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
