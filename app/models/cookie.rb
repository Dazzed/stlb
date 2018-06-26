class Cookie < ActiveRecord::Base
  belongs_to :storage, polymorphic: :true
  
  validates :storage, presence: true

  validates :quantity, numericality: { greater_than: 0 }

  def ready?
    true
  end
end
