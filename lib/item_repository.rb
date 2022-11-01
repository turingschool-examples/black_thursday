class ItemRepository
  def initialize(list)
    @list = list
  end

  def all
    @list
  end

  def find_by_id(num)
    @list.find {|item| item.id == num}
  end

  def find_by_name(name)
    @list.find {|item| item.name == name}
  end
end