require_relative 'element'

# This class defines items
class Merchant
  include Element

  def initialize(attributes, engine = nil)
    @attributes = attributes
    @engine = engine
  end
end
