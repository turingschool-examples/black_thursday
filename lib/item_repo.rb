require './lib/item'
require 'csv'
require 'pry'

class ItemRepo
  attr_reader :all,
              :name,
              :id,
              :description,
              :merchant_id,
              :created_at,
              :updated_at
              
  def initialize(file, sales_engine)
    @parent = sales_engine
    @all = []
    file_reader(file)
  end

 def file_reader(file)
    contents = CSV.open(file, headers:true, header_converters: :symbol)
    contents.each do |item|
       @all << Item.new(item, self)
    end
  end

  def find_by_id(desired_id)
    @all.find do |item|
      item.id == desired_id
    end
  end

  def find_by_name(desired_name)
    @all.find do |item|
      item.name.downcase == desired_name
      return item.id
    end
  end

  def find_all_with_description(desired_description)
    @all.find_all do |item|
      item.description.downcase == desired_description
    end
    #returns instances of item where the supplied string occurs in the description
    #case insensitive
  end

  def find_all_by_price(desired_price)
  #returns objects that match with price provided
    @all.find_all do |item|
      item.unit_price == desired_price
      return item.name
    end

  end

  def find_all_by_price_in_range(price1, price2)
    #returns objects that match with range price provided
      @all.find_all do |item|
        item.unit_price >= price1 &&
        item.unit_price <= price2
        return item.name
      end
  end

  def find_all_by_merchant_id(merchant_id)
    #search merchant with that id
    #returns all items of that merchant
    @all.find_all do |item|
      item.merchant_id == merchant_id
      return item.name
    end

  end
end
