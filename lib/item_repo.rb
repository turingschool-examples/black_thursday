require_relative '../lib/item'
require_relative '../lib/load_file'
class ItemRepo
  attr_reader :items,
              :contents,
              :parent,
              :repository

    def initialize(data, parent)
        @repository = data.map do |row| 
             Item.new(row, self)
        end
        @parent = parent
    end

    def all
        repository
    end

    def find_by_id(id)
        repository.find do |item|
            item.id == id
        end
    end

    def find_by_name(name)
        repository.find do |item|
            item.name.downcase == name.downcase
        end
    end
    
    def find_all_with_description(description)
        repository.find_all do |item|
            item.description.downcase.include?(description.downcase)
        end
    end

    def find_all_with_price(price)
        repository.find_all do |item|
            item.unit_price == BigDecimal.new(price)
        end
    end

   def find_all_with_price_in_range(price_range)
    repository.find_all do |item|
      price_range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(id)
    repository.find_all do |item| 
        item.merchant_id == id
    end
  end

  def find_merchant_by_merchant_id(merchant_id)
    parent.find_merchant_by_merchant_id(merchant_id)
  end

def find_max_id
   max = repository.max_by { |item| item.id }
   max.id.to_i
 end

 def create(attrs)
   new_id = find_max_id + 1
   attrs[:id] = new_id.to_s
   new_merchant = Item.new(attrs, self)
   new_merchant.created_at = Time.now
   new_merchant.updated_at = Time.now
   repository << new_merchant
   return new_merchant
 end


end
