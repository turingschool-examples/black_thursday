require_relative 'element'

# This class defines Transaction
class Transaction
  include Element

  def initialize(attributes)
    @attributes = attributes
  end
end
