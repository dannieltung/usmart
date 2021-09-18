class Category < ApplicationRecord
  belongs_to :user
  has_many :payments

  validates :name, presence: true, :length => { :minimum => 2 }, :uniqueness => true

  before_create :adjustments

  before_update :adjustments

  private

  def adjustments
    self.name = name.titleize
  end
end
