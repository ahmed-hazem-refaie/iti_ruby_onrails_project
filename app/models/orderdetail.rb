class Orderdetail < ApplicationRecord
  validates :item, :amount, :price, presence: true, presence: true
  validates :price, numericality: true
  validates :item, numericality: false
  belongs_to :user
  belongs_to :order
end
