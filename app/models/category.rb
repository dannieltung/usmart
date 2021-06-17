class Category < ApplicationRecord
  belongs_to :user
  has_many :payments

  validates :name, presence: true
end
