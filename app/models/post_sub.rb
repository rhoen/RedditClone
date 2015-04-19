class PostSub < ActiveRecord::Base
  belongs_to :posts
  belongs_to :subs
end
