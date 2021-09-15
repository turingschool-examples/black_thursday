require 'csv'


#CSV::Converters[:hashify] = ->(value) { stuff = value }

class ItemRepository
attr_reader :all


  @@filename = './data/items.csv'
  def initialize
    @all = fill_items
  end

  def fill_items
    all_items = CSV.parse(File.read(@@filename))
    categories = all_items.shift
    grouped_items = []

    all_items.each do |item|
      individual_item = {}
      categories.zip(item) do |category, attribute|

        individual_item[category.to_sym] = attribute
      end
      grouped_items << Item.new(individual_item)
    end
    grouped_items
  end

  def find_by_id(id)
    @all.find do |item|
      item.id.to_i == id.to_i
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end.uniq
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price.to_i == price.to_i
    end
  end


  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id.to_i == merchant_id.to_i
    end
  end
end
