require_relative 'element'

# This class defines items
class Item
  include Element

  def initialize(attributes)
    @attributes = attributes
  end

  def value
    unit_price
  end
end
