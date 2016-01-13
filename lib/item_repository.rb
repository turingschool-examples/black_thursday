require 'pry'
require 'csv'
require 'set'
require_relative 'items'

class ItemRepository

  def initialize(items)
    parse_items(items)
  end

  def parse_items(items)
    @items_array = []
    items.each do |row|
      id   = row[:id]
      name = row[:name]
      description = row[:description]
      unit_price = row[:unit_price]
      created_at = row[:created_at]
      updated_at = row[:updated_at]

      @items_array << Items.new({:id => id,
                                 :name => name,
                                 :description => description,
                                 :unit_price => unit_price,
                                 :created_at => created_at,
                                 :updated_at => updated_at})
    end
  end

  def all
    @items_array
  end

  # def find_all_by_name(fragment)
  #   fragment = fragment.downcase
  #   @items_array.select do |merchant|
  #     if merchant.name.downcase.include?(fragment)
  #       merchant.name
  #     end
  #   end
  # end

  def find_by_name(item_name)
    if name_object = @items_array.find { |n| n.name.downcase == item_name.downcase}
      name_object
    else
      nil
    end
  end

  def find_by_id(item_id)
    if id_object = @items_array.find { |i| i.id == item_id}
      id_object
    else
      nil
    end
  end

end

if __FILE__ == $0
# mr = MerchantRepository.new('./data/items.csv')
# merchant_list = mr.load_data('./data/merchants.csv')
# mr.find_id(12334105)
# puts mr.parse_data(12334105)
end
