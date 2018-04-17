# frozen_string_literal: true

# merchant has attributes which contain id and name in a hash
class Merchant
  attr_reader :attributes

  def initialize(attributes)
    attributes[:id] = attributes[:id].to_i
    attributes[:created_at] = Time.parse(attributes[:created_at])
    attributes[:updated_at] = Time.parse(attributes[:updated_at])
    @attributes = attributes
  end

  def id
    @attributes[:id]
  end

  def name
    @attributes[:name]
  end
end
