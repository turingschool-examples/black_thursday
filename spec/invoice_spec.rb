require_relative '../lib/sales_engine'
require_relative '../lib/invoice_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../lib/invoice'

require 'bigdecimal/util'

RSpec.describe Invoice do

  describe '#initialize' do
    invoice = Invoice.new({
                            :id          => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status      => "pending",
                            :created_at  => Time.now,
                            :updated_at  => Time.now,
                          })

    it 'exists' do
      expect(invoice).to be_instance_of(Invoice)
    end

    it 'has attributes accessible' do

      expect(invoice.id).to eq(6)
      expect(invoice.customer_id).to eq(7)
      expect(invoice.merchant_id).to eq(8)
      expect(invoice.status).to eq("pending")
      expect(invoice.created_at.class).to eq(Time)
      expect(invoice.updated_at.class).to eq(Time)
    end

  end

end
