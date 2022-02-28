require 'pry'
require_relative 'spec_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'

RSpec.describe InvoiceItemRepository do
  before(:each) do
    se = SalesEngine.from_csv({ :items=> "./data/items.csv",
                                :merchants => "./data/merchants.csv",
                                :invoice_items => "./data/invoice_items.csv"})

    @invoice_items = se.invoice_items
  end

  it "exists" do
    expect(@invoice_items).to be_a(InvoiceItemRepository)
  end

  it "#all returns array of all know InvoiceItem instances" do
    expect(@invoice_items.all.count).to eq(21830)
  end

  it "#find_by_id returns nil or instance with matching id" do

    expected = @invoice_items.find_by_id(1)
    expect(expected.id).to eq(1)
    expect(@invoice_items.find_by_id(10000000)).to be nil

  end

  it "find_all_by_item_id one or more matches" do
#binding.pry
      item_id = 263408101
      expected = @invoice_items.find_all_by_item_id(item_id)
      expect(expected.length).to eq(11)
      expect(expected.first.class).to eq InvoiceItem
    end

   it "#find_all_by_item_id returns an empty array if there are no matches" do
      item_id = 10
      expected = @invoice_items.find_all_by_item_id(item_id)

      expect(expected.length).to eq 0
      expect(expected.empty?).to eq true
    end
    it "#create " do

      attributes = {
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }
    @invoice_items.create(attributes)
    expected = @invoice_items.find_by_id(21831)
    expect(expected.item_id).to eq 7
    end

    it "#update " do
      original_time = @invoice_items.find_by_id(1).updated_at
      attributes = { quantity: 13 }

      expected = @invoice_items.update(1, attributes)

      expect(expected.quantity).to eq 13
      expect(expected.item_id).to eq 263519844
      expect(expected.updated_at).to be > original_time
    end

    it "#deletes by id" do
      @invoice_items.delete(1)
      expected = @invoice_items.find_by_id(1)
      expect(expected).to eq nil
    end
end
