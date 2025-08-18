class Product < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "category", "price", "created_at", "updated_at"]
  end
end
