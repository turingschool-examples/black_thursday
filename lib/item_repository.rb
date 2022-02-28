# require 'CSV'
require 'pry'
require_relative './sales_engine.rb'
require_relative './findable.rb'
require_relative './item.rb'
require_relative './crudable.rb'
require 'BigDecimal'
# require 'simplecov'
# SimpleCov.start

# This class takes one argument at initialization, an array of all Item instances. It is intended that the SalesEngine instance will take care of creating this array from its given CSV directory, and pass that array to this instance of ItemRepository at time of creation (when SalesEngine#items(item_object_array) is called)
class ItemRepository # < SalesEngine
  include Findable
  include Crudable
  attr_reader :all
  attr_accessor :new_object

  def initialize array
    @all = array
    @new_object = Item
  end

  def inspect
  end

  # vvv LET'S MOVE THIS LOGIC TO THE SALES ENGINE CLASS! vvv (with some modification)
  # def self.from_csv(path_string)
  #   csv_source = CSV.read(path_string, headers: true, header_converters: :symbol)
  #   item_object_array = []
  #   csv_source.each do |line|
  #     item = Item.new({ id: line[:id].to_i, name: line[:name], description: line[:description],
  #                       merchant_id: line[:merchant_id].to_i, unit_price: BigDecimal(line[:unit_price]), created_at: line[:created_at], updated_at: line[:updated_at] })
  #     item_object_array << item
  #   end
  #   self.new(item_object_array)
  # end
  # ^^^ LET'S MOVE THIS LOGIC TO THE SALES ENGINE CLASS! ^^^

  def find_all_with_description(descriptive_string)
    @all.find_all { |item| item.description.downcase.include?(descriptive_string.downcase) }
  end

  # note- price in this hash is stored in cents, not dollars!
  def find_all_by_price(desired_price)
    @all.find_all { |item| item.unit_price.to_i == desired_price }
  end

  def find_all_by_price_in_range(price_range_object)
    @all.find_all { |item| price_range_object.member?(item.unit_price.to_i) }
  end

  def find_all_by_merchant_id(merchant_id_string)
    @all.find_all { |item| item.merchant_id == merchant_id_string }
  end

  # def create(info_hash)
  #   current_largest_item_id = (@all.max { |current, subsequent|
  #                                current.id <=> subsequent.id
  #                              }).id # @all.max returns an Item instance, on which we can call id
  #   info_hash[:id] = current_largest_item_id + 1
  #   info_hash[:created_at] = Time.now.getutc if !(info_hash[:created_at])
  #   info_hash[:updated_at] = Time.now.getutc
  #   new_item = Item.new(info_hash)
  #   @all << new_item
  # end
  #
  # def update(id, info_hash)
  #   find_by_id(id).update(info_hash)
  # end
  #
  # def delete(id)
  #   index = @all.find_index(find_by_id(id))
  #   @all.delete_at(index)
  # end
end
