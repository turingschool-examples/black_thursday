require_relative 'item'
require_relative 'repository_module'

class ItemRepository
  include RepositoryModule

  def initialize(data_file)
    @repository = data_file.map {|item| Item.new(item)}
  end

  # def find_all_with_description(description)
  #   @repository.find_all do |item|
  #     item.attributes[:description] == description
  #   end
  # end
end

# *find_all_with_description(description) - returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
# *find_all_by_price(price) - returns either [] or instances of Item where the supplied price exactly matches
# *find_all_by_price_in_range(range) - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
# *find_all_by_merchant_id(merchant_id) - returns either [] or instances of Item where the supplied merchant ID matches that supplied
# *create(attributes) - create a new Item instance with the provided attributes. The new Item’s id should be the current highest Item id plus 1.
# *update(id, attributes) - update the Item instance with the corresponding id with the provided attributes. Only the item’s name, desription, and unit_price attributes can be updated. This method will also change the items updated_at attribute to the current time.
