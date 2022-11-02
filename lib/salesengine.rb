require './lib/item_repository.rb'
require './lib/item.rb'
class SalesEngine
  attr_reader :items

  def initialize(files)
    @items = ItemRepository.new(files[:items])
    # @merchants = csv[:merchants]
  end

end
