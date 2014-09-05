class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  
  belongs_to :user

  scope :added_to_cart, -> { where(ordered: false) }
  scope :mycart, -> { where(ordered: true) }

  def total_price
    product.price * quantity
  end

end
