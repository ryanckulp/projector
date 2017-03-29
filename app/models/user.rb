class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :email

  has_many :projects, dependent: :destroy
  has_many :events, through: :projects
  has_many :suggestions, dependent: :destroy

  def product_hunt_votes
    projects.map(&:product_hunt_votes).inject(0, &:+)
  end
end
