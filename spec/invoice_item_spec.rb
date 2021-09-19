require "Rspec"
require "bigdecimal"
require_relative "../lib/invoice_item"

describe InvoiceItem do
  before :each do
    @ii = InvoiceItem.new({
              id: '1',
         item_id: '263519844',
      invoice_id: '1',
        quantity: '5',
      unit_price: '13635',
      created_at: '2016-01-11 09:34:06 UTC',
      updated_at: '2017-06-04 21:35:10 UTC'
    })
  end

  it 'is an invoice item' do
    expect(@ii).to be_a InvoiceItem
  end

  it '#attributes' do

    expect(@ii.id).to eq 1
    expect(@ii.item_id).to eq 263519844
    expect(@ii.invoice_id).to eq 1
    expect(@ii.quantity).to eq 5
    expect(@ii.unit_price).to eq 0.13635e3
    expect(@ii.created_at).to be_a Time
    expect(@ii.updated_at).to be_a Time
  end

  it '#unit_price_to_dollars' do
    expect(@ii.unit_price_to_dollars).to eq (136.35)
  end
end
