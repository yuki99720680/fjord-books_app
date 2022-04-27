class Follow < ApplicationRecord
  belongs_to :following, class_name: 'User', uniqueness: { scope: :follower }
  belongs_to :follower, class_name: 'User'
end
