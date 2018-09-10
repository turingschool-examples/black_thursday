require_relative './merchant'

class Item < Merchant
  # XXX: How do we keep a flexible and scalable design, but match the
  # initialization parameters? Thought: make the "initialize" method so it
  # takes the converted parameters, and make a custom initializer that takes
  # a raw parameter list, converts it, then calls the main initializer with
  # those conversions.

  def initialize(refined_attributes)
    @attributes = refined_attributes
  end

  def self.from_raw_hash(raw_attributes)
    # Psuedocode:
    # Take "raw" data hash. "Validate" the hash.
    # Convert each attribute to proper type & add to a refined attribute hash
    # call Item.new(refined_attributes)
    self.new(raw_attributes)
  end

  def valid_attributes?(attributes)
  end

  # TODO: Make tests for these
  def description
    @data[:description]
  end

  # TODO: Make this big decimal
  def unit_price
    @data[:unit_price]
  end

  # TODO: Make it a date/time object? Check type in specs
  def created_at
    @data[:created_at]
  end

  # TODO: Make it a date/time object? Check type in specs
  def updated_at
    @data[:updated_at]
  end

  def merchant_id
    @data[:merchant_id].to_i
  end
end
