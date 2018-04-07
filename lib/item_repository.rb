# frozen_string_literal: true

# This object holds all of the items. On initialization, we feed in the
# seperated out list of items, which we obtained from the CSV file. For each
# row, denoted here by the item variable, we insantiate a new item object that
# includes a reference to it's parent. We store this list in the item_list
# isntance variable, allowing us to reference the list outside of this class.
# The list is stored as an array.
class ItemRepository
  attr_reader :item_list,
              :parent
  def initialize(items, parent)
    @item_list = items.map { |item| Item.new(item, self) }
    @parent = parent
  end

  def find_all_by_description
  end

  def find_all_by_price(price)
  end

  def find_all_by_price_in_range(range)

  end

  def find_all_by_merchant_id(merchant_id)
  end

  def update(id, attribute)
  end

end
