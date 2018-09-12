require_relative './data_object'

class Item < DataObject
  def initialize(attributes)
    @editable = [:name, :description, :unit_price]
    super(attributes)
  end

  # def valid_attributes?(attributes)
  #
  # end

  def description
    @attributes[:description]
  end

  def unit_price
    @attributes[:unit_price]
  end

  def unit_price_to_dollars
    @attributes[:unit_price].to_f.round(2)
  end

  def created_at
    @attributes[:created_at]
  end

  def updated_at
    @attributes[:updated_at]
  end

  def merchant_id
    @attributes[:merchant_id].to_i
  end

  def update(attributes)
    super(attributes)
    @attributes[:updated_at] = Time.now
  end
end
