class Project < ActiveRecord::Base
  belongs_to :user
  has_many :events, dependent: :destroy

  before_create :generate_client_id

  def generate_client_id
    self.client_id = loop do
      random = SecureRandom.hex(10)
      break random unless Project.where(client_id: random).present?
    end
  end

end
