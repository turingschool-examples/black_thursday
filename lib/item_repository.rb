require_relative "item"


class ItemRepository
  attr_reader :repository, :parent
  def initialize(item_csv, parent)
    @item_csv = CSV.open item_csv, headers: true, header_converters: :symbol
    @parent = parent
    make_repository
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

  def make_repository
    @repository = {}
    @item_csv.read.each do |item|
      @repository[item[:id]] = Item.new(item, self)
    end
    return self
  end

  def all
    @repository.map do  |key, value|
      value
    end
  end

  def find_by_id(id)
    if @repository[id.to_s]
      @repository[id.to_s]
    else
      nil
    end
  end

  def find_by_name(name_search)
    all.find do |value|
      value.name.downcase == name_search.downcase
    end
  end

  def find_all_with_description(description)
    all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end
  
  def find_all_by_price(price)
    all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    all.find_all do |item|
      range.include? item.unit_price_to_dollars 
    end
  end

  def find_all_by_merchant_id(id)
    all.find_all do |item|
      item.merchant_id == id
    end
  end

end
