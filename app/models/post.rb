class Post < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  belongs_to :place
  belongs_to :user
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  after_create :create_favorite
  after_create :create_vote

  default_scope { order('rank DESC') }


  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :link, length: { minimum: 10 }, presence: true
  validates_format_of :link, :with => /\/\/(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=|embed\/)?([a-z0-9_\-]+)/i , :on => :create
  validates :place, presence: true
  validates :user, presence: true

  def up_votes
     votes.where(value: 1).count
   end

   def down_votes
     votes.where(value: -1).count
   end

   def points
     votes.sum(:value)
   end

   def update_rank
     age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
     new_rank = points + age_in_days
     update_attribute(:rank, new_rank)
   end


   private

   def create_favorite
     Favorite.create(post: self, user: self.user)
     FavoriteMailer.new_post(self).deliver_now
   end

   def create_vote
     user.votes.create(value: 1, post: self)
   end

end
