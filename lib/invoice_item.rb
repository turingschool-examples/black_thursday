require_relative 'element'

# This class defines InvoiceItems
class InvoiceItem
  include Element

  def initialize(attributes, engine = nil)
    @attributes = attributes
    @engine = engine
  end

  def item_id
    @attributes[:item_id].to_i
  end

  def quantity
    @attributes[:quantity].to_i
  end

  def update(states)
    super(states)
    attributes[:item_id] = states[:item_id] if states[:item_id]
    attributes[:quantity] = states[:quantity] if states[:quantity]
  end
end
