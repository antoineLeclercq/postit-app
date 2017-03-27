class Comment < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post
  has_many :votes, as: :voteable

  validates :body, presence: true

  def net_votes_count
    votes.where(vote: true).size - votes.where(vote: false).size
  end
end