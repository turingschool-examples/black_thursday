require 'bigdecimal'
require_relative 'spec_helper'

RSpec.describe InvoiceItemRepository do

  before(:each) do
    @paths = {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
    }
    @se = SalesEngine.from_csv(@paths)
  end

  it "exists" do
    ir = @se.invoice_items

    expect(ir).to be_a(InvoiceItemRepository)
  end

  it "calls and reads correct file path" do
    ir = @se.invoice_items
    ir_csv_data = ir.all

    expect(ir_csv_data.class).to eq(Array)
    expect(ir_csv_data.length).to eq(21830)

    data_validation = ir_csv_data.all? do |line|
      line.class == Invoice
    end

    expect(data_validation).to be(true)
  end

  it 'can find all invoice_items by id' do
    ir = @se.invoice_items
    id = 10
    result = ir.find_by_id(id)

    expect(result.id).to eq(id)
    expect(result.item_id).to eq(263523644)
    expect(result.invoice_id).to eq(2)
  end

  it 'can find all invoice by a given item_id' do
    ir = @se.invoice_items
    item_id = 263408101
    result = ir.find_all_by_item_id(item_id)

    expect(result.length).to eq(11)
    expect(result.first.class).to eq(InvoiceItem)
  end

  it 'can find all invoice matching given invoice item id' do
    ir = @se.invoice_items
    invoice_item_id = 100
    result = ir.find_all_by_invoice_id(invoice_id)

    expect(result.length).to eq(3)
    expect(result.first.class).to eq(InvoiceItem)
  end

  it 'can create new instance with attributes' do
    ir = @se.invoice_items
    new_invoice = {
          :item_id => 7,
          :invoice_id => 8,
          :quantity => 1,
          :unit_price => BigDecimal.new(10.99,4),
          :created_at => Time.now,
          :updated_at => Time.now
        }

    ir.create(new_invoice)
    result = ir.find_by_id(21831)

    expect(result.item_id).to eq(7)
  end

  it 'can update an existing Invoice instance' do
    ir = @se.invoice_items
    original_time = ir.find_by_id(21831).updated_at
    time_stub = '2021-05-30 11:30:51.343158 -050'
    allow(Time).to receive(:now).and_return(time_stub)
    attributes = {
          :item_id => 7,
          :invoice_id => 8,
          :quantity => 13,
          :unit_price => BigDecimal.new(10.99,4),
          #not getting testing but believe we should test
          :created_at => Time.now,
          :updated_at => Time.now
      }

      ir.update(21831, attributes)
      result = ir.find_by_id(21831)

      expect(result.quantity).to eq(13)
      expect(result.item_id).to eq attributes[:item_id]
      expect(Time.parse(result.updated_at)).to be > original_time
      result = ir.find_by_item_id(5000)
      expect(result).to eq nil
    end

  it 'can delete an existing InvoiceItem instance' do
    ir = @se.invoice_items

    old_length = ir.all.length
    result = ir.delete(ir.all[0].id)
    new_length = ir.all.length

    expect(old_length - new_length).to eq(1)
  end
end
