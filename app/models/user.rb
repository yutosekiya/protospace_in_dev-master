class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, UserImageUploader

  has_many :prototypes
  has_many :likes, dependent: :destroy
  has_many :prototypes, through: :likes

  validates :name, presence: true

  def like?(prototype)
    likes.exists?(prototype_id: prototype.id)
  end
end
