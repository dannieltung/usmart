class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :credit_card
  belongs_to :category
  belongs_to :buyer
end
