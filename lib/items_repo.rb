require 'csv'
require_relative 'items'
class ItemRepo

  attr_reader :all_items, :parent

  def initialize(file, se=nil)
    @all_items = []
    open_file(file)
    @parent = se
  end

  def open_file(file)
    CSV.foreach file,  headers: true, header_converters: :symbol do |row|
      all_items << Item.new(row, self)
    end
  end

  def all
    @all_items
  end
  
  def find_by_id(item_id)
    all_items.find {|item| item.id == item_id }
  end


  def find_by_name(name)
    all_items.find {|item| item.name.downcase == name.downcase}
  end

  def find_all_with_description(desc)
    all_items.find_all do |item|
      item.description.downcase.include?(desc.downcase)
    end
  end

    def find_by_name(name)
      all_items.find {|item| item.name.downcase == name.downcase}
    end

  def find_all_by_price(price)
    all_items.find_all {|item| item.unit_price == price}
  end

  def find_all_by_price_in_range(range)
    all_items.find_all do |item|
      range.include?(item.unit_price)
    end
  end

    # def find_all_with_description(description)
    #   all_items.find do |item|
    #     item.description.include?
    #   end
    # end

  def find_all_by_merchant_id(id)
    all_items.find_all {|item| item.merchant_id == id}
  end


  def merchant_item(id)
    parent.merchant_item(id)
  end

end
