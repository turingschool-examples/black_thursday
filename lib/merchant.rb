require_relative 'element'

# This class defines items
class Merchant
  include Element

  def initialize(attributes)
    @attributes = attributes
  end
end
