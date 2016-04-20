require './lib/item'

class ItemRepository
  attr_reader :item_repository

  def initialize(parent)
    @se = parent
    @item_repository = []
  end

  def items(item_repo)
    item_repo.each do |column|
      @item_repository << Item.new(column, self)
    end
    self
  end

  def all
    item_repository.empty? ?  nil : @item_repository
  end

  def find_by_id(find_id)
    item_repository.find {|item| item.id == find_id }
  end

  def find_by_name(find_name)
    item_repository.find {|item| item.name.downcase == find_name.downcase }
  end

  def find_all_with_description(find_description)
    item_repository.find_all do |item|
      item.description.downcase == find_description.downcase
    end
  end

  def find_all_by_price(price)
    item_repository.find_all {|item| item.unit_price == price}

  end

  def find_all_by_price_in_range(range)
    item_repository.find_all {|item| range.include?(item.unit_price)}
  end

  def find_all_by_merchant_id(find_merchant_id)
    item_repository.find_all do |item|
      item.merchant_id == find_merchant_id
    end
  end

  def find_merchant_by_merch_id(merchant_id)
    @se.find_merchant_by_merch_id(merchant_id)
  end

end
