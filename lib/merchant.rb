class Merchant
  attr_reader :attributes_hash,
              :id,
              :name
  def initialize(attributes_hash)
    @attributes_hash = attributes_hash
    @id = attributes_hash[:id]
    @name = attributes_hash[:name]
  end





end
