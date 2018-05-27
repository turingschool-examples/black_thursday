require_relative 'item'

class ItemRepository
  attr_reader :item_repo,
              :parent

  def initialize(loaded_file, parent)
    @item_repo = loaded_file.map { |item| Item.new(item, self)}
    @parent = parent
  end

  def all
    @item_repo
  end

  
end
