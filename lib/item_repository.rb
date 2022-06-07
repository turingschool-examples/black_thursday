require 'csv'
require 'item'
require 'pry'
require 'BigDecimal'

class ItemRepository
  attr_reader :all
  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true,
    header_converters: :symbol) do |row|
      @all << Item.new({:id => row[:id], :name => row[:name],
        :description => row[:description], :unit_price => row[:unit_price],
        :created_at => row[:created_at], :updated_at => row[:updated_at],
        :merchant_id => row[:merchant_id]})
    end
  end

  def find_by_id(id)
    @all.find do |item|
      item.id ==  id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.upcase == name.upcase
    end
  end

  def find_all_with_description(description)
    items = []
    @all.each do |item|
      if item.description.include?(description) == true
        items << item
      end
    end
    items
  end

  def find_all_with_price(price)
    items = []
    @all.each do |item|
      if item.unit_price == BigDecimal(price)/100
        items << item
      end
    end
    items
  end

  def find_all_by_price_in_range(range)
    items = []
    @all.each do |item|
      if range.include?(item.unit_price)
        items << item
      end
    end
    items
  end

  def find_all_by_merchant_id(merchant_id)
    items = []
    @all.each do |item|
      if item.merchant_id == merchant_id
        items << item
      end
    end
    items
  end

  def create(attributes)
    highest_id = []
    @all.each do |item|
      highest_id << item.id.to_i
    end
    attributes[:id] = (highest_id.max + 1).to_s
    @all << Item.new(attributes)
  end

  def update (id, attributes)
    @all.each do |item|
      if item.id == id
        item.name = attributes[:name]
        item.description = attributes[:description]
        item.unit_price = attributes[:unit_price]
        item.updated_at = Time.now
      end
    end
  end

  def delete(id)
    @all.find do |item|
      item.id == id
      @all.delete(item)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
