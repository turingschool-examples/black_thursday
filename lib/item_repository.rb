require_relative './item'

class ItemRepository

  attr_reader :all

  def initialize
    @all = []
  end

  def find_by_id(id)
    @all.find do |item|
      if item.id == id
        return item
      end
      nil
    end
  end

end
