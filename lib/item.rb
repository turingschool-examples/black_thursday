require_relative './data_object'

class Item < DataObject

  def initialize(refined_attributes)
    @attributes = refined_attributes
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
