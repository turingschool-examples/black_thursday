require_relative 'spec_helper'
require_relative '../lib/invoice_item'

RSpec.describe InvoiceItem do
  before (:each) do
    @ii = InvoiceItem.new({
  :id => 6,
  :item_id => 7,
  :invoice_id => 8,
  :quantity => 1,
  :unit_price => BigDecimal.new(10.99, 4),
  :created_at => Time.now,
  :updated_at => Time.now
  })
  end
end
