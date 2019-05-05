require_relative '../lib/item'
require_relative '../lib/load_file'
class ItemRepo
  attr_reader :items,
              :contents,
              :parent

    def initialize(data, parent)
        @items = data.map {|row| Item.new(row, self)}
        @parent = parent
    end

    def all
        items
    end

    def find_by_id(id)
        items.find do |item|
            item.id == id
        end
    end

    def find_by_name(name)
        items.find do |item|
            item.name.downcase == name.downcase
        end
    end
    
    def find_all_with_description(description)
        items.find_all do |item|
            item.description.downcase.include?(description.downcase)
        end
    end

    def find_all_with_price(price)
        items.find_all do |item|
            item.unit_price == BigDecimal.new(price)
        end
    end

    def find_all_with_price_in_range(price_range)
        items.find_all do |item|
        price_range.include?(item.unit_price)
        end
    end

  def find_all_by_merchant_id(id)
    items.find_all do |item| 
        item.merchant_id == id
    end
  end

  def find_merchant_by_merchant_id(merchant_id)
    parent.find_merchant_by_merchant_id(merchant_id)
  end

    def find_max_id
        max = items.max_by { |item| item.id }
        max.id.to_i
    end

    def create(attrs)
        new_id = find_max_id + 1
        attrs[:id] = new_id.to_s
        new_merchant = Item.new(attrs, self)
        new_merchant.created_at = Time.now
        new_merchant.updated_at = Time.now
        items << new_merchant
        return new_merchant
    end

    def update(id, attrs)
        item_to_update = find_by_id(id)
        item_to_update.name = attrs[:name]
        item_to_update.description = attrs[:description]
        item_to_update.unit_price = BigDecimal.new(attrs[:unit_price])/100
        item_to_update.updated_at = Time.now
    end

    def delete(id)
        item_to_delete = find_by_id(id)
        items.delete(item_to_delete)
    end


end