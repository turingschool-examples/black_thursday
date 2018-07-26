require_relative 'item'
require_relative 'repository_assistant'

class ItemRepository
  include RepositoryAssistant

  def initialize(data_file)
    @repository = data_file.map {|item| Item.new(item)}
  end

  def find_all_with_description(description)
    @repository.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @repository.find_all do |item|
      item.unit_price_to_dollars == price.to_f
    end
  end

  def find_all_by_price_in_range(range)
    @repository.find_all do |item|
      range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(id)
    @repository.find_all do |item|
      item.merchant_id == id
    end
  end

  def create(attributes)
    attributes[:id] = create_new_id_number
    @repository << Item.new(attributes)
  end

  def inspect
  "#<#{self.class} #{@items.size} rows>"
  end
end
