class Discourse < ActiveRecord::Base
  belongs_to :project
  has_one :theme, :through => :project
  has_one :chair, :through => :project
  has_one :conference, :through => :project
  has_many :comments, :dependent => :destroy
  has_many :rates, :dependent => :destroy

  scope :with_rates, ->{ joins(:rates).uniq }

  validates_presence_of :authors, :title, :description

  has_attached_file :file, :storage => :elvfs, :elvfs_url => Settings['storage.url']
  validates_attachment_content_type :file, :content_type => ["application/pdf"]
  validates_attachment_presence :file

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

  def detailed_participants
   project_participants = gpo_request("#{Settings["gpo.url"]}/api/projects/#{self.project.gpo_id}/participants")
   result = authors.map do |author|
     if p = project_participants.select{ |p| p['name'].to_s.squish == author }.first
       "#{author}(гр.#{p["edu_group"]})"
     else
       author
     end
   end
   result.join(", ")
  end

  def project_managers
    gpo_request("#{Settings["gpo.url"]}/api/projects/#{self.project.gpo_id}/project_managers").compact.
      map{|pm| pm["name"].squish}.join(", ")
  end


  private

  def gpo_request(url)
    begin
    hash = RestClient::Request.execute(
                       method: :get,
                       url: url,
                       timeout: 600,
                       headers: { :Accept => 'application/json', :timeout => 600 },
                      ) do |response, request, result, &block|
                      JSON.parse(response)
    end
    hash
    rescue
      {}
    end
  end
end
