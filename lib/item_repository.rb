class ItemRepository

attr_reader :all
  def initialize(items)
    @all = items
  end


  def find_all_by_name(search)
    @all.find_all{|index| index.name.upcase.include?(search.upcase)}
  end
end
