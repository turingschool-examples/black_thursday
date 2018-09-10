require_relative './item'
require_relative './repository'

class ItemRepository < Repository

  def initialize(filepath)
    super()
    load_items(filepath)
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol ) do |data|
      @data << Item.new(data)
    end
  end

  def find_all_with_description(description)
    @data.find_all do |datum|
      datum.description.include?(description)
    end
  end

  def find_all_by_price(price)
    @data.find_all do |datum|
      datum.unit_price == price
    end
  end

  def find_all_by_price_range(range)
    @data.find_all do |datum|
      range.include?(datum.unit_price)
    end
  end



end
