require_relative 'element'

# This class defines items
class Merchant
  include Element

  def initialize(attributes, engine = nil)
    @attributes = attributes
    @engine = engine
  end

  def round(decider)
    if decider == 'item'
      @engine.items.find_all_by_merchant_id(id).count
    elsif decider == 'invoice'
      @engine.invoices.find_all_by_merchant_id(id).count
    end
  end
end
