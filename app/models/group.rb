class Group < ApplicationRecord
  has_many :group_user, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  has_many :users, through: :group_users
  
  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image
  
  def is_owned_by?(user)
    owner_id == user.id   
    # owner.id
  end
  
end
