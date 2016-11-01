require './lib/item'

class ItemRepository

  attr_reader :all	

  def initialize(items)
  	@all = items
  end

  def find_by_id(id)
    all.find {|item| item.id == id.to_s}
  end

  def find_by_name(name)
  	all.find {|item| item.name.upcase == name.upcase}
  end

  def find_all_with_description(description)
  	all.find_all do |item|
  	  item.description.upcase.include?(description.upcase)
  	end
  end

end


