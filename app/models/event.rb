class Event < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :participations
  has_many :join_users, through: :participations, source: :user
  belongs_to :owner, class_name: 'User'
  belongs_to_active_hash :level

  include ActiveModel::Validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :place, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 250 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates_with EventValidator

  acts_as_taggable #追加
  # acts_as_taggable_on :tags　と同じ意味のエイリアス
  # tags のなかにIDやら名前などが入る。イメージ的には親情報。

  # current_userがすでに参加しているかどうかのメソッド
  def participated_by?(user)
      participations.where(user_id: user.id).exists?
  end

end
