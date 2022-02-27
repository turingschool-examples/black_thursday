require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/invoice_item'
require 'CSV'
require 'simplecov'
SimpleCov.start

RSpec.describe InvoiceItem do

  describe 'create an invoice item' do

      ii = InvoiceItem.new({
        :id => 6,
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal.new(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
        })

    it 'exists' do
      expect(ii).to be_a(InvoiceItem)
    end

  end

end
