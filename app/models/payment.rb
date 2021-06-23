class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :credit_card
  belongs_to :buyer
  belongs_to :category

  validates :description, presence: true
  validates :date, presence: true
  validates :total_amount, presence: true

  before_create :adjustments

  private

  def adjustments
    total_partial.nil? ? self.total_partial = 1 : total_partial
  end
end
