require_relative 'sales_engine'
require_relative 'item'

class ItemRepository
  # Responsible for holding and searching our Items instances.
  attr_reader :items

  def initialize(items)
    @items = items
    @item_repository = []
    create_all_items
  end

  def create_all_items
    @items.each do |item|
      @item_repository << Item.new(item)
    end
  end

  def all
    @item_repository
  end

  def find_by_id(id)
    @item_repository.find do |item|
      id == item.id
    end
  end

  def find_by_name(name)
    @item_repository.find do |item|
      name == item.name
    end
  end

  def find_all_by_name(name)
    @item_repository.find_all do |item|
      item.name.include?(name)
    end
  end

  def create(attributes)
    highest_id = @item_repository.max_by { |item| (item.id)}
    attributes[:id] = ((highest_id.id) + 1)
    @item_repository << Item.new(attributes)
  end

  def delete(id)
    item = find_by_id(id)
    @item_repository.delete(item)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  # def update(id, attributes)
  #   update the Item instance with the corresponding id with the provided attributes. Only the item’s name, desription, and unit_price attributes can be updated. This method will also change the items updated_at attribute to the current time.
  # end

  #def find_all_with_description(description)
  # returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
  #end

  # def find_all_by_price(price)
  #- returns either [] or instances of Item where the supplied price exactly matches
  #end

  # def find_all_by_price_in_range(range)
  #- returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
  #end

  # find_all_by_merchant_id(merchant_id)
  #- returns either [] or instances of Item where the supplied merchant ID matches that supplied
  #end

end
