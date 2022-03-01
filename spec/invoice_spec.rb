require './lib/invoice'
require 'time'

RSpec.describe 'Invoice' do
  invoice = Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
  })
  it 'exists' do
    expect(invoice).to be_an_instance_of(Invoice)
  end

  it 'has all expected attributes' do
    expect(invoice.invoice_attributes[:id]).to eq(6)
    expect(invoice.invoice_attributes[:customer_id]).to eq(7)
    expect(invoice.invoice_attributes[:merchant_id]).to eq(8)
    expect(invoice.invoice_attributes[:status]).to eq("pending")
    expect(invoice.invoice_attributes[:created_at]).to be_an_instance_of(Time)
    expect(invoice.invoice_attributes[:updated_at]).to be_an_instance_of(Time)
  end
end
