class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :week_favorites, -> {where(created_at: 1.week.ago.beginning_of_day..Time.current.end_of_day)}
  has_many :book_comments, dependent: :destroy

  
  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(title: content)
    elsif method == 'forward'
      User.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('title LIKE ?', '%' + content)
    else
      User.where('title LIKE ?', '%' + content + '%')
    end
  end

end
