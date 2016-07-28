require_relative "../lib/item"
require "csv"
require 'pry'

class ItemRepository
attr_reader :all

  def initialize(data_path, sales_engine = nil)
    @sales_engine = sales_engine
    @all = []
    csv_loader(data_path)
    item_maker
  end

  def csv_loader(data_path)
    @csv = CSV.open data_path, headers:true, header_converters: :symbol
  end

  def item_maker
    @all = @csv.map do |row|
      Item.new(row, self)
    end
  end

  def find_by_id(id_input)
    @all.find do |instance|
      instance.id == id_input.to_i
    end
  end

  def find_by_name(name_input)
    @all.find do |instance|
      instance.name == name_input.to_s
    end
  end

  def find_all_by_description(description_fragment)
    @all.find_all do |instance|
      instance.description.include?(description_fragment.to_s)
    end
  end

  def find_all_by_price(price)
    @all.find_all do |instance|
      instance.unit_price.to_i == BigDecimal.new(price).to_i
    end
  end
 def find_all_by_price_in_range(range)
   

 end



end
