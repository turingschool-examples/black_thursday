require_relative '../lib/item'
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
    contents = CSV.read(file, headers:true, header_converters: :symbol)
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
      item.name.downcase == desired_name.downcase
    end
  end

  def find_all_with_description(desired_description)
    @all.find_all do |item|
      item.description.downcase == desired_description.downcase
    end
  end

  def find_all_by_price(desired_price)
    @all.find_all do |item|
      item.unit_price == desired_price
    end
  end

  def find_all_by_price_in_range(range)
      p = @all.find_all do |item|
        item.unit_price >= range.begin &&
        item.unit_price <= range.end
      end
      p
  end

  def find_all_by_merchant_id(merchant_id)
    i = @all.find_all do |item|
      item.merchant_id == merchant_id.to_i
    end
    i
  end

end