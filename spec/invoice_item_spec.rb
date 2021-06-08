require 'simplecov'
SimpleCov.start
require 'rspec'
require './lib/invoice_item'
require 'bigdecimal'

RSpec.describe InvoiceItem do
  describe 'instantiation' do
    it 'creates a new invoice item' do
      ii = InvoiceItem.new({
                            :id => 6,
                            :item_id => 7,
                            :invoice_id => 8,
                            :quantity => 1,
                            :unit_price => BigDecimal(10.99, 4),
                            :created_at => Time.now,
                            :updated_at => Time.now
                          },self)

      expect(ii).to be_an_instance_of(InvoiceItem)
    end

    it "has readable attributes" do
      ii = InvoiceItem.new({
                            :id => 6,
                            :item_id => 7,
                            :invoice_id => 8,
                            :quantity => 1,
                            :unit_price => BigDecimal(10.99, 4),
                            :created_at => Time.now,
                            :updated_at => Time.now
                          },self)

      expect(ii.id).to eq(6)
      expect(ii.quantity).to eq(1)
      expect(ii.invoice_id).to eq(8)

    end
  end

  describe "it's methods" do
    it "can convert unit price to dollars" do
      ii = InvoiceItem.new({
                            :id => 6,
                            :item_id => 7,
                            :invoice_id => 8,
                            :quantity => 1,
                            :unit_price => BigDecimal(10.99, 4),
                            :created_at => Time.now,
                            :updated_at => Time.now
                          },self)

      expect(ii.unit_price_to_dollars).to eq(0.11)
    end
  end

end
