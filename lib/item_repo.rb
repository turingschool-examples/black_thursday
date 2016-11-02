require './lib/item'
require 'csv'
require 'pry'

class ItemRepo
  attr_reader :all
  def initialize
    # @parent = SalesEngine.new
    @all = []
  end

  def set_up(file)
    file = CSV.read "./data/items.csv", headers: true, header_converters: :symbol
    parse_file(file)
  end

  def all
    @all
  end

  def parse_file(file)
    CSV.foreach("./data/items.csv") do |row|
      next if row[0] == "id"
      instantiate_item(row)
    end
  end

  def instantiate_item(row)
      item = {:id => row[0],
        :name => row[1],
        :description => row[2],
        :unit_price => row[3],
        :merchant_id => row[4],
        :created_at => row[5],
        :updated_at => row[6]
        }
      @all << Item.new(item, self)
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

      @all.find_all do |item|
        item.unit_price >= price1 &&
        item.unit_price <= price2
        return item.name
      end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
      return item.name
    end

  end
end
