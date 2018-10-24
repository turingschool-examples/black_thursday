 class ItemRepository

   def initialize(items)
     @items = items
   end

   def all
     @items
   end

   def find_by_id(id)
    all.find do |item|
      item.id == id
    end
   end

   def find_by_name(name)
     @items.find do |item|
       item.name.upcase == name.upcase
     end
   end

   def find_all_with_description(desc)
     @items.find_all do |item|
       item.description.upcase.include?(desc.upcase)
     end
   end

   def find_all_by_price(price)
     price = BigDecimal.new(price,4)
     all.find_all do |item|
       item.unit_price == price
     end
   end

   def find_all_by_price_in_range(range)
     all.find_all do |item|
       range.member?(item.unit_price)
     end
   end

   def find_all_by_merchant_id(id)
     all.find_all do |item|
       item.merchant_id == id
     end
   end

   def create(attributes)
     max_id = all.max_by do |item|
       item.id
     end
     new_id = max_id.id + 1
     name = attributes[:name]
     description = attributes[:description]
     unit_price = attributes[:unit_price]
     created_at = Time.now
     updated_at = Time.now
     merchant_id = attributes[:merchant_id]
     new_item = Item.new({name: name, description: description, id: new_id,
       unit_price: unit_price, created_at: created_at, updated_at: updated_at,
       merchant_id: merchant_id})
     @items << new_item
     new_item
   end

   def update(id, attributes)
     item = find_by_id(id)
     new_name = attributes[:name]
     new_description = attributes[:description]
     new_unit_price = attributes[:unit_price]

     item.name = new_name
     item.description = new_description
     item.unit_price = new_unit_price
     item.updated_at = Time.now
   end

   def delete(id)
     item = find_by_id(id)
     @items.delete(item)
   end

   def inspect
     "#<#{self.class} #{@items.size} rows>"
   end

 end
