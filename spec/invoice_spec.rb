require 'rspec'
require './lib/invoice'

RSpec.describe Invoice do
  it 'exists' do
    invoice = Invoice.new({id: "1", customer_id: "1", merchant_id: "12335938", status: "pending", created_at: "2009-02-07", updated_at: "2014-03-15"}, self)

    expect(invoice).to be_a(Invoice)
  end

  it 'has attributes' do
    invoice = Invoice.new({id: "1", customer_id: "1", merchant_id: "12335938", status: "pending", created_at: "2009-02-07", updated_at: "2014-03-15"}, self)

    expect(invoice.id).to eq(1)
    expect(invoice.customer_id).to eq(1)
    expect(invoice.merchant_id).to eq(12335938)
    expect(invoice.status).to eq("pending")
    expect(invoice.created_at).to eq("2009-02-07")
    expect(invoice.updated_at).to eq("2014-03-15")
    expect(invoice.repo).to eq(self)
  end
end
