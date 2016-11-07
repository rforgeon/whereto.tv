class Post < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  belongs_to :place
  belongs_to :user

  default_scope { order('created_at DESC') }


  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :link, length: { minimum: 10 }, presence: true
  validates :place, presence: true
  validates :user, presence: true


end
