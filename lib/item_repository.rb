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
    data
  end

  def find_by_id(id)
    data.select do |row|
      if row.id == id
        return row.id
      else
        return nil
      end
    end
  end

  def find_by_name(name)
    data.select do |row|
      if row.name == name
        return row.name
      else
        return nil
      end
    end
  end
  # def find_all_with_description
  #   # returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
  # end
  #
  # def find_all_by_price
  #   # returns either [] or instances of Item where the supplied price exactly matches
  # end
  #
  # def find_all_by_price_in_range
  #   # returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
  # end
  #
  # def find_all_by_merchant_id
  #   # returns either [] or instances of Item where the supplied merchant ID matches that supplied
  # end

  def inspect
   "#<#{self.class} #{@merchants.size} rows>"
  end

end
