require_relative '../lib/invoice'
require 'time'

RSpec.describe Invoice do
  it 'exists and has attributes' do
    time = Time.now.to_s
    invoice = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => time,
      :updated_at  => time,
    })

    expect(invoice).to be_a(Invoice)
    expect(invoice.id).to eq 6
    expect(invoice.customer_id).to eq 7
    expect(invoice.merchant_id).to eq 8
    expect(invoice.status).to eq(:pending)
    expect(invoice.created_at).to eq Time.parse(time)
    expect(invoice.updated_at).to eq Time.parse(time)
  end
end