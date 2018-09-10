class Merchant
  def initialize(attributes)
    @attributes = attributes
  end

  def self.from_raw_hash(raw_attributes)
    # Psuedocode:
    # Take "raw" data hash. "Validate" the hash.
    # Convert each attribute to proper type & add to a refined attribute hash
    # call Item.new(refined_attributes)
    self.new(raw_attributes)
  end

  # TODO: Make tests for these
  def id
    @attributes[:id].to_i
  end

  def name
    @attributes[:name]
  end
end
