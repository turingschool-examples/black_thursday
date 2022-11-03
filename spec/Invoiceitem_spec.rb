require './lib/invoice_item.rb'
require 'bigdecimal'

RSpec.describe InvoiceItem do
  let(:invoice_item) {InvoiceItem.new({
                                        :id           => 6,
                                        :item_id      => 7,
                                        :invoice_id   => 8,
                                        :quantity     => 1,
                                        :unit_price   => BigDecimal(10.99, 4),
                                        :created_at   => Time.now,
                                        :updated_at   => Time.now
                                      })}

  it 'exists and takes in info and gives access to them' do
    allow(Time).to receive(:now).and_return(@time_now)

    expect(invoice_item).to be_a(InvoiceItem)
    expect(invoice_item.id).to eq(6)
    expect(invoice_item.item_id).to eq(7)
    expect(invoice_item.invoice_id).to eq(8)
    expect(invoice_item.quantity).to eq(1)
    expect(invoice_item.unit_price).to eq(BigDecimal(10.99, 4))
    expect(invoice_item.created_at).to eq(Time.now)
    expect(invoice_item.updated_at).to eq(Time.now)
  end

  it 'has a method to return unit price in dollar and cents format' do
    expect(invoice_item.unit_price_to_dollars).to eq(0.1099)
  end

end