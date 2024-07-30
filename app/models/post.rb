class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_one_attached :photo

  validates :title, presence: true
  validates :content, presence: true
  validates :url, presence: true
end
