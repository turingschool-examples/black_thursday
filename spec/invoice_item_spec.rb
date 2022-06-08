require './lib/invoice_item'
require 'BigDecimal'

RSpec.describe InvoiceItem do
  before :each do
    @invoice_item = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => 1099,
      :created_at => Time.parse('1994-05-07 23:38:43 UTC'),
      :updated_at => Time.parse('2016-01-11 11:30:35 UTC')
    })
  end

  describe "#initialize" do
    it "is an Item" do
      expect(@invoice_item).to be_a InvoiceItem
    end

    it "has an ID" do
      expect(@invoice_item.id).to eq 6
    end

    it "has a item id" do
      expect(@invoice_item.item_id).to eq 7
    end

    it "has a invoice id" do
      expect(@invoice_item.invoice_id).to eq 8
    end

    it "has a quantity" do
      expect(@invoice_item.quantity).to eq 1
    end

    it "has a unit price" do
      expect(@invoice_item.unit_price).to eq 0.1099e2
    end

    it "has a created time" do
      expect(@invoice_item.created_at).to eq Time.parse('1994-05-07 23:38:43 UTC')
    end

    it "has an updated time" do
      expect(@invoice_item.updated_at).to eq Time.parse('2016-01-11 11:30:35 UTC')
    end
  end

  describe "#unit_price_to_dollars" do
    it "returns a unit price as a float" do
      expect(@invoice_item.unit_price_to_dollars).to eq 10.99
    end
  end
end
