# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :following, class_name: 'Follow', foreign_key: 'following_id', inverse_of: :following, dependent: :destroy
  has_many :follower, class_name: 'Follow', foreign_key: 'follower_id', inverse_of: :follower, dependent: :destroy
  has_many :following_user, through: :following
  has_many :following_user, through: :follower
end
