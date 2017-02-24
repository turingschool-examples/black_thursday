require 'csv'
require_relative 'repository'
require_relative 'item'

class ItemRepository < Repository

  attr_reader :klass, :data

  def initialize(path)
    klass = Item
    super(path, klass)
  end

  def all
    @data
  end

  def find_by_id(id)
    data.select { |item| item.id == id }
  end

  def find_by_name(name)
    data.select { |item| item.name.downcase == name.downcase }.first
  end

  def find_all_with_description(description_string)
      if data.include? description_string
          return row.description
      end
  end


  # def find_all_by_price
  #   # returns either [] or instances of Item where the supplied price exactly matches
  # end

  def inspect
   "#<#{self.class} #{@merchants.size} rows>"
  end

end
