require_relative './repo_module'
require_relative './item'


class ItemRepository
  include RepoModule

  attr_reader :all

  def initialize(file_path)
    @class_name = Item
    @all = from_csv(file_path)
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(price_range)
    @all.find_all do |item|
       item.unit_price_to_dollars >= price_range.first && item.unit_price_to_dollars <= price_range.last
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

end
