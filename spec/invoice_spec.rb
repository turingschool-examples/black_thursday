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

  describe '#time_check' do
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              })
    item = sales_engine.items.all[0]

    it 'returns input as originally passed in if input is class Time' do
      time_object = Time.parse("2007-06-04 21:35:10 UTC")
      expect(item.time_check(time_object)).to eq(time_object)
    end

    it 'returns input converted to Time object if input is not class Time' do
      expect(item.time_check("2007-06-04 21:35:10 UTC")).to eq(Time.parse("2007-06-04 21:35:10 UTC"))
    end
  end

end
