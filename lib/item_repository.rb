require 'csv'

class ItemRepository

  attr_reader     :all,
                  :parent

  def initialize(parent = nil)
    @all = []
    @parent = parent
  end

  def populate(filename)
    contents = CSV.open(filename, headers: true,
     header_converters: :symbol)

    contents.each do |row|
      @all << Item.new(row, self)
    end
  end

  def find_by_id(id)
    @all.find do |item|
      item.id.to_i == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.downcase.strip == name.downcase.strip
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price.to_i == price
    end
  end

  def find_all_by_price_in_range(price_range)
    @all.find_all do |item|
      price_range.include?(item.unit_price.to_i)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id.to_i == merchant_id
    end
  end

end
