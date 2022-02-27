require 'pry'
require_relative 'spec_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repository'

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

  it "holds @all invoice_item data"
    expect(@invoice_item.all.count).to eq(21830)
