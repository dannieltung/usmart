class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :credit_card


  validates :date, presence: true
  validates :total_amount, presence: true

  before_create :adjustments

  private

  def adjustments
    self.total_partial = 1 if total_partial.nil?
    self.description = description.titleize
  end
end
