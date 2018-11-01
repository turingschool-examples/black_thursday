require 'csv'
require 'time'
require_relative '../lib/item'
require_relative '../lib/repository'

class ItemRepository

 include Repository

 def initialize(items)
   @collection = items
 end

 def find_all_with_description(desc)
   all.find_all do |item|
     item.description.upcase.include?(desc.upcase)
   end
 end

   def find_all_by_price(price)
     price = BigDecimal.new(price,4) #make this dynamic later
     all.find_all do |item|
       item.unit_price.to_digits == price.to_digits
       # binding.pry
     end
   end

   def find_all_by_price_in_range(range)
     all.find_all do |item|
       # binding.pry
       range.member?(item.unit_price)
     end
   end

 def find_all_by_merchant_id(id)
   all.find_all do |item|
     item.merchant_id == id
   end
 end

 def create(attributes)
   new_item = Item.new({name: attributes[:name],
                        description: attributes[:description],
                        id: max_id + 1,
                        unit_price: attributes[:unit_price],
                        created_at: Time.now.to_s,
                        updated_at: Time.now.to_s,
                        merchant_id: attributes[:merchant_id]})
   @collection << new_item
   new_item
 end

 def update(id, attributes)
   if find_by_id(id)
     item = find_by_id(id)
     # new_name = attributes[:name]
     # new_description = attributes[:description]
     # new_unit_price = attributes[:unit_price]
     item.name = attributes[:name] if attributes[:name]
     item.description = attributes[:description] if attributes[:description]
     item.unit_price = attributes[:unit_price] if attributes[:unit_price]
     item.updated_at = Time.now
   end
 end

end
