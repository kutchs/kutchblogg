class Post < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories
  #belongs_to :category
  has_many :comments, dependent: :destroy

  has_many :favorites
  has_many :favorited_by_users, through: :favorites, source: :user

  has_one_attached :photo

  validates :title, presence: true
  validates :content, presence: true
  validates :url, presence: true
end



