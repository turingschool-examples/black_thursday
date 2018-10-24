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
 end
