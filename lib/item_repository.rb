class ItemRepository
  def initialize(list)
    @list = list
  end

  def all
    @list
  end

  def find_by_id(num)
    @list.find {|item| item.id == 2}
  end
end