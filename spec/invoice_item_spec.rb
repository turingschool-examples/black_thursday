require 'pry'
require 'rspec'
require 'csv'
require 'date'
require 'bigdecimal/util'
require './lib/invoice_item'
require './lib/sales_module'

RSpec.describe InvoiceItem do
  before(:each) do
    @ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99,4),
      :created_at => Time.new(2022, 02, 27),
      :updated_at => Time.new(2022, 02, 28)
                          })
  end

  describe "instantiation" do
    it "creates instance" do
      expect(@ii).to be_an_instance_of(InvoiceItem)
    end


    it "has readable attributes" do
      # allow(Time).to receive(:now).and_return(@time_now)
      expect(@ii.id).to eq(6)
      expect(@ii.item_id).to eq(7)
      expect(@ii.invoice_id).to eq(8)
      expect(@ii.quantity).to eq(1)
      expect(@ii.unit_price).to eq(BigDecimal(10.99, 4))
      expect(@ii.created_at).to eq(Time.new(2022, 02, 27))
      expect(@ii.updated_at).to eq(Time.new(2022, 02, 28))
    end
  end

    it "returns price of item in dollars as a float" do
      expect(@ii.unit_price_to_dollars).to eq(10.99)
    end
end
