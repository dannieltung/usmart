class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_many :payments, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :credit_cards, dependent: :destroy
  has_many :buyers, dependent: :destroy

  after_create :self_buyer, :safe_category

  private

  def self_buyer
    Buyer.create(name: first_name, user_id: id)
  end

  def safe_category
    Category.create(name: '', user_id: id)
  end
end
