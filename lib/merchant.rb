require_relative 'element'

# This class defines merchants
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

  # shouldn't use engine
  def total
    invoices = @engine.invoices.find_all_by_merchant_id(id)
    total = 0
    invoices.each do |invoice|
      sa = @engine.analyst
      total += sa.invoice_total(invoice.id) if sa.invoice_paid_in_full?(invoice.id)
    end
    total
  end
end
