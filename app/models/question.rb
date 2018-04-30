class Question < ActiveRecord::Base
  validates :question, presence: true, length: { maximum: 1024 }
  validates :author, presence: true, length: { maximum: 256 }
  validates :country, presence: true, length: { maximum: 256 }
  validates :state, presence: true, length: { maximum: 256 }
end
