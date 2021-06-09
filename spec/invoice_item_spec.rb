require 'SimpleCov'
SimpleCov.start

require_relative '../lib/invoice_item'
require 'bigdecimal'

RSpec.describe InvoiceItem do
  before :each do
    @ii = InvoiceItem.new({
                             :id           => 6,
                             :item_id      => 7,
                             :invoice_id   => 8,
                             :quantity     => 1,
                             :unit_price   => BigDecimal(1099, 4),
                             :created_at   => '2021-06-11 09:34:06 UTC',
                             :updated_at   => '2021-06-11 09:34:06 UTC'
                          })
  end

  it 'Exists' do
    expect(@ii).to be_an_instance_of(InvoiceItem)
  end

  it 'Has attributes' do
    expect(@ii.id).to eq(6)
    expect(@ii.item_id).to eq(7)
    expect(@ii.invoice_id).to eq(8)
    expect(@ii.quantity).to eq(1)
    expect(@ii.unit_price).to eq(BigDecimal(10.99, 4))
    expect(@ii.created_at).to eq(Time.parse('2021-06-11 09:34:06 UTC'))
    expect(@ii.updated_at).to eq(Time.parse('2021-06-11 09:34:06 UTC'))
  end

  it 'Can parse time or create time' do
    expect(@ii.created_at).to be_a(Time)
    expect(@ii.updated_at).to be_a(Time)

    allow(@ii).to receive(:created_at).and_return(Time.parse('2021-06-11 02:34:56 UTC'))
    expect(@ii.created_at).to eq(Time.parse('2021-06-11 02:34:56 UTC'))
  end

  it 'Can update attributes' do
    @ii.update({
                  :quantity => 2,
                  :unit_price => BigDecimal(25.99, 4)
               })

    expect(@ii.quantity).to eq(2)
    expect(@ii.unit_price_to_dollars).to eq(25.99)
    expect(@ii.updated_at).to be_a(Time)
  end

  it 'Can change unit price to dollars' do
    expect(@ii.unit_price).to be_a(BigDecimal)
    expect(@ii.unit_price_to_dollars).to eq(10.99)
  end
end
