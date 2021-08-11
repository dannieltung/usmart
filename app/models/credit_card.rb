class CreditCard < ApplicationRecord
  belongs_to :user
  has_many :payments

  validates :due_day, presence: true, format: { with: /\A[1-9]$|^[1-2][0-9]$|^3[0-1]f\z/, message: 'Deve ser entre 1 e 31.' }
  validates :best_day, presence: true
  validates :name, presence: true

  before_create :adjustments

  private

  def adjustments
    self.name = name.titleize
  end
end
