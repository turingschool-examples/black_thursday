require 'csv'
require_relative 'item'
require_relative 'merchant_repository'

class ItemRepository
attr_reader :data, :file, :all_items, :item
attr_accessor :merchant_repository

  def initialize(file)
    @merchant_repository = merchant_repository
    @all_items = []
    @file = file
    data_into_hash(load_data(file))
  end

  def load_data(file)
    @data = CSV.open (file), headers: true, header_converters:
    :symbol
  end

  def data_into_hash(data)
    data.each do |row|
      item_id = row[:id]
      name = row[:name]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      description = row[:description]
      merchant_id = row[:merchant_id]

      hash = {:id => item_id,
              :description => description, :merchant_id => merchant_id,
              :name => name,
              :created_at => created_at, :updated_at => updated_at}
      @item = Item.new(hash)
      item.merchant = merchant_id
      # assign_item_its_merchant
      @all_items << item
    end
  end

  # def assign_item_its_merchant
  #   item.merchant = merchant_repository.find_by_id(item.merchant_id)
  # end

  def find_by_id(number)
    all_items = @all_items
    all_items.find do |x|
      x.id == number
    end
  end

  def find_by_name(name)
    @all_items.find do |x|
      x.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @all_items.find_all do |x|
      x.description.downcase == description.downcase
    end
  end

  def find_all_by_price

  end

  def find_all_by_price_in_range

  end

  def find_all_by_merchant_id(id)
    @all_items.find_all do |x|
      x.merchant_id == id
    end
  end
end
