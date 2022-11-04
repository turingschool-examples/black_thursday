require 'bigdecimal'
require './lib/modules/repository_queries'


class ItemRepository
include RepositoryQueries
  
  attr_reader :data

  def initialize(data, engine)
    @data = create_data(data)
    @engine = engine
  end

  # def all
  #   @data
  # end

  def find_by_id(id)
    nil if !a_valid_id?(id)

    @data.find do |item|
      item.id == id
    end
  end

  def a_valid_id?(id)
    @data.any? do |item| item.id == id
    end
  end

  def find_by_name(name)
    @data.find{|item| item.name.downcase == name.downcase}
  end

  def find_all_by_name(string)
    @data.find_all do |item|
      item.name.downcase.include?(string.downcase)
    end
  end
  
  def create(attribute)
    new_id = @data.last.id + 1
    @data << Item.new({:id => new_id, :name => attribute}, self)
  end
  
  def find_all_with_description(string)
    @data.find_all do |item|
      item.description.downcase.include?(string.downcase)
    end
  end

  def find_all_by_price(price)
    @data.find_all do |item|
      item.unit_price == price.to_f
    end
  end
  
  def find_all_by_price_in_range(low, high)
    @data.find_all do |item|
      item.unit_price >= low.to_f && item.unit_price <= high.to_f
    end
  end
  
  def find_merchant_by_id(id)
    @engine.find_by_merchant_id(id)
  end

  def find_all_by_merchant_id(id)
    @data.find_all do |item|
      item.merchant_id == id.to_i
    end
  end

  def create(attributes)
    new_id = @data.last.id + 1
    attributes[:id] = new_id
    @data << Item.new(attributes, self)
  end

  # Let's refactor this to use our #find_by_id method
  def update(id, attributes)
    @data.each do |item|
      if item.id == id
      item.update(id, attributes)
      end
    end
  end
  
  def delete(id)
    @data.delete(find_by_id(id))
  end

  ##### Generate data
  def create_data(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol, quote_char: '"'
    make_item_object(contents)
  end
  
  def make_item_object(contents)
    contents.map do |row|
      item = {
              :id => row[:id].to_i, 
              :name => row[:name],
              :description => row[:description],
              :unit_price => row[:unit_price].to_f,
              :created_at => row[:created_at],
              :updated_at => row[:updated_at],
              :merchant_id => row[:merchant_id].to_i
            }
      Item.new(item, self)
    end
  end
  
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end