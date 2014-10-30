class Discourse < ActiveRecord::Base
  belongs_to :project
  has_one :theme, :through => :project
  has_one :chair, :through => :project
  has_one :conference, :through => :project
  has_many :comments, :dependent => :destroy
  has_many :rates, :dependent => :destroy

  scope :with_rates, ->{ joins(:rates).uniq }

  validates_presence_of :authors, :vfs_path, :title, :description
  validates_format_of :vfs_path, :with => /\.pdf\z/, :message => 'файл имеет неверный формат, необходим PDF'

  serialize :authors

  normalize_attribute :authors do |array|
    array.select { |value| value.present? }
  end

  def experts
    @experts ||= rates.map(&:user).compact
  end

  def rate_for(user)
    rates.rated_by(user).first || rates.rated_by(user).build
  end

  def rate_for?(user)
    rate_for(user).persisted?
  end

  def average_rate
    "%.1f" % (rates.average('cached_total') || 0)
  end

end
