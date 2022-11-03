require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'

RSpec.describe InvoiceItem do
  @time = Time.now
  before :each do
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
    expect(@ii.unit_price).to eq BigDecimal(1099, 4)
    expect(@ii.created_at).to eq @time
    expect(@ii.updated_at).to eq @time
  end
end