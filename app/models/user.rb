# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  comments_count         :integer
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  likes_count            :integer
#  photos_count           :integer
#  private                :boolean
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default Devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :photos, foreign_key: :owner_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :fan_id, dependent: :destroy

  # Follow Requests
  has_many :sent_follow_requests, class_name: 'FollowRequest', foreign_key: :sender_id, dependent: :destroy
  has_many :received_follow_requests, class_name: 'FollowRequest', foreign_key: :recipient_id, dependent: :destroy

  def following?(other_user)
    received_follow_requests.exists?(sender: self, recipient: other_user, status: 'accepted')
  end

  def follow_request_pending?(other_user)
    follow_requests.exists?(recipient: other_user, status: 'pending')
  end

  # Accepted Follow Requests
  has_many :accepted_sent_follow_requests, -> { where(status: 'accepted') }, class_name: 'FollowRequest', foreign_key: :sender_id
  has_many :accepted_received_follow_requests, -> { where(status: 'accepted') }, class_name: 'FollowRequest', foreign_key: :recipient_id

  # Followers and Following Users
  has_many :following_users, through: :accepted_sent_follow_requests, source: :recipient
  has_many :followers, through: :accepted_received_follow_requests, source: :sender

  # Validations
  validates :username, presence: true, uniqueness: true
end
