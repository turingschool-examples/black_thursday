require_relative 'element'

# This class defines items
class Item
  include Element

  def initialize(attributes)
    @attributes = attributes
  end

  def description
    @attributes[:description]
  end

  def update(states)
    super(states)
    attributes[:description] = states[:description] if states[:description]
  end
end
