# frozen_string_literal: true

# merchant has attributes which contain id and name in a hash
class Merchant
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def id
    attributes[:id]
  end

  def name
    attributes[:name]
  end
end
