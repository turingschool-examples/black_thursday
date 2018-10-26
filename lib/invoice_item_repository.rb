require_relative 'repository'
require_relative 'invoice_item'

class InvoiceItemRepository < Repository
  attr_reader :type, :attr_whitelist
  def initialize
    @type = InvoiceItem
    @attr_whitelist = [:quantity, :unit_price]
    super
  end

  def find_all_by_item_id(item_id)
    @instances.find_all {|invoice_item| invoice_item.item_id == item_id}
  end

  def find_all_by_invoice_id(invoice_id)
    @instances.find_all {|invoice_item| invoice_item.invoice_id == invoice_id}
  end

  def find_all_by_date(date)
    result = @instances.find_all do |invoice_item|
      result = invoice_item.created_at.to_date == date.to_date
      result
    end

    result
  end
end
