require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'

RSpec.describe InvoiceItem do
  before :each do
    @time = Time.now.to_s
    @ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(1099, 4),
      :created_at => @time,
      :updated_at => @time
    })
  end

  it 'exists and has attributes' do
    expect(@ii).to be_a InvoiceItem
    expect(@ii.id).to eq 6
    expect(@ii.item_id).to eq 7
    expect(@ii.invoice_id).to eq 8
    expect(@ii.quantity).to eq 1
    expect(@ii.unit_price).to eq 10.99
    expect(@ii.created_at).to eq Time.parse(@time)
    expect(@ii.updated_at).to eq Time.parse(@time)
  end

  it 'can return the unit price in dollars' do
    expect(@ii.unit_price_to_dollars).to eq 10.99
  end
end