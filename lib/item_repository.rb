require 'csv'

class ItemRepository #< SalesEngine
  def initialize(items)
    @item_repo = items
  end

  def all
    @item_repo
  end

  def find_by_id(id)
    if @item_repo.one? { |item| item.id == id } == true
      @item_repo.find { |item| item.id == id }
    else
      nil
    end 
  end
end
