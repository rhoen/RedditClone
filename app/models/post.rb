class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  validate :at_least_one_sub

  belongs_to :author, class_name: "User"
  has_many :post_subs, inverse_of: :post
  has_many :subs, through: :post_subs, source: :sub

  def at_least_one_sub
    errors[:base] << "must have at least one sub" unless self.subs.size >= 1
  end
end
