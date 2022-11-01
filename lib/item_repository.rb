require 'bigdecimal'

class ItemRepository
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find_all do |item|
      if item.id == id
        return item
      else @items.empty?
        return nil
      end 
    end 
  end

  # def find_by_name(name)
  #   @items.find{|item| item.name == name}
  # end
  
end