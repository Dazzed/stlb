class Oven < ActiveRecord::Base
  belongs_to :user
  has_many :cookies

  validates :user, presence: true
end
