class Question < ActiveRecord::Base
  validates :question, presence: true, length: { maximum: 1024 }
  validates :author_string, presence: true
end
