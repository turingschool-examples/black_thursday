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

  def find_by_name(name)
    @all.find do |item|
      if item.name.downcase == name.downcase
        return item
      end
      nil
    end
  end

  def find_all_with_description(description)
    result = []
    @all.find do |item|
      if item.description.downcase == description.downcase
        result << item
      end
    end
    result
  end

end
