class Cookie < ActiveRecord::Base
  belongs_to :oven
  
  validates :oven, presence: true
end
