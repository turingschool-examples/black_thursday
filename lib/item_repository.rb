require 'CSV'
require_relative 'item'

class ItemRepository

  def initialize(file_path, engine)
    create_repo(file_path)
    @engine = engine
  end

  def create_repo(file_path)
    @items = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      item = Item.new(row, self)
      @items << item
    end
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def all
    @items
  end

  def find_by_id(id)
  end

  def find_by_name(name)
  end

  def find_all_with_description(description)
  end

  def find_all_by_price(price)
  end

  def find_all_by_price_in_range(range)
  end

  def find_all_by_merchant_id(merchant_id)
  end

  def create(attributes)
  end

  def update(id, attributes)
  end

  def delete(id)
  end
end
