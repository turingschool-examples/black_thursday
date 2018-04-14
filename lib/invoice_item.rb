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
    attributes[:quantity] = states[:quantity] if states[:quantity]
  end

  # def amount_paid
  #   unit_price * quantity
  # end
end
