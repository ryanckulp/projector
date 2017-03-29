class Project < ActiveRecord::Base
  belongs_to :user
  has_many :events, dependent: :destroy

  before_create :generate_client_id
  after_create :lookup_product_hunt_votes

  def generate_client_id
    self.client_id = loop do
      random = SecureRandom.hex(10)
      break random unless Project.where(client_id: random).present?
    end
  end

  def lookup_product_hunt_votes
    self.product_hunt_votes = product_hunt_vote_count
    self.save!
  end

  def product_hunt_slug
    self.product_hunt_url.split("/posts/")[1]
  end

  def product_hunt_vote_count
    resp = Curl.get("https://api.producthunt.com/v1/posts/all?search[slug]=#{product_hunt_slug}") do |curl|
      curl.headers['Authorization'] = "Bearer #{ENV['PH_ACCESS_TOKEN']}"
    end

    return unless resp.status.include?('20')

    data = JSON.parse(resp.body)
    post = data['posts'][0]
    post['votes_count']
  end

end
