require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice'
require 'bigdecimal/util'

RSpec.describe InvoiceItem do

  describe '#initialize' do
    invoice_item = InvoiceItem.new({
                                                    :id => 6,
                                                    :item_id => 7,
                                                    :invoice_id => 8,
                                                    :quantity => 1,
                                                    :unit_price => ("1099"),
                                                    :created_at => Time.now,
                                                    :updated_at => Time.now
                                                  })

    it 'exists' do
      expect(invoice_item).to be_instance_of(InvoiceItem)
    end

    it 'has attributes available' do
      expect(invoice_item.id).to eq(6)
      expect(invoice_item.item_id).to eq(7)
      expect(invoice_item.invoice_id).to eq(8)
      expect(invoice_item.quantity).to eq(1)
      expect(invoice_item.unit_price).to eq(10.99)
      expect(invoice_item.created_at.class).to eq(Time)
      expect(invoice_item.updated_at.class).to eq(Time)
    end
  end

  describe '#time_check' do
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv",
                              :invoice_items => "./data/invoice_items.csv",
                              :customers => "./data/customers.csv"
                              })
    invoice_item = sales_engine.items.all[0]

    it 'returns input as originally passed in if input is class Time' do
      time_object = Time.parse("2007-06-04 21:35:10 UTC")
      expect(invoice_item.time_check(time_object)).to eq(time_object)
    end

    it 'returns input converted to Time object if input is not class Time' do
      expect(invoice_item.time_check("2007-06-04 21:35:10 UTC")).to eq(Time.parse("2007-06-04 21:35:10 UTC"))
    end
  end
end
