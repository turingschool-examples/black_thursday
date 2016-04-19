require 'csv'
require_relative 'item'

class ItemRepository

  def initialize(arg1)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
