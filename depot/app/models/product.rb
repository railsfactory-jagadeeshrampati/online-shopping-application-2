class Product < ActiveRecord::Base
 has_many :line_items
 has_attached_file :image
 before_destroy :ensure_not_referenced_by_any_line_item
#validates :title, :description, :image_url, presence: true
 validates :price, numericality: {greater_than_or_equal_to: 0.01}
 validates :title, uniqueness: true
 
 validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
 def add_product(product_id, current_user)
        current_item = current_user.line_items.where(order_id: nil).find_by(product_id: product_id)
         if current_item
          current_item.quantity += 1
         else
          current_item = current_user.line_items.build(product_id: product_id)
      end
        
      current_item
   end

private
# ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
     return true
    else
     errors.add(:base, 'Line Items present')
     return false
    end
  end
  def self.latest
   Product.order(:updated_at).last
  end

end


