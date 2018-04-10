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

    def find_by_name(item)
        repository.find do |item|
            item.name.downcase == name.downcase
        end
    end
    
    def find_all_with_description(description)
        repository.find_all do |item|
            item.description.downcase.include?(description.downcase)
        end
    end

    def find_all_by_price(price)
        repository.find_all do |item|
            item.price == BigDecimal.new(price)
        end
    end

   def find_all_by_price_in_range(price_range)
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



end
