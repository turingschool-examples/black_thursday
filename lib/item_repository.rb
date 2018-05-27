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

  def find_by_id(id_num)
    item_repo.find {|item| item.id == id_num}
  end

  def find_by_name(name)
    item_repo.find {|item| item.name == name}
  end

  def find_all_with_description(description)
    item_repo.find_all {|item| item.description.downcase == description.downcase}
  end

  def find_all_by_price(price)
    item_repo.find_all {|item| item.unit_price.to_f == price.to_f}
  end
end
