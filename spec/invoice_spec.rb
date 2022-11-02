require './lib/invoice'

RSpec.describe Invoice do
  let(:invoice) {Invoice.new({
                              :id          => 6,
                              :customer_id => 7,
                              :merchant_id => 8,
                              :status      => "pending",
                              :created_at  => "2022-11-02 15:50:00.281414 -0700",
                              :updated_at  => "2022-11-02 15:50:00.281414 -0700"
                              })}

  it 'is an instance of an invoice and has attributes' do
    allow(Time).to receive(:now).and_return(@time_now)
    
    expect(invoice).to be_a(Invoice)
    expect(invoice.id).to eq(6)
    expect(invoice.customer_id).to eq(7)
    expect(invoice.merchant_id).to eq(8)
    expect(invoice.status).to eq("pending")
    
    expect(invoice.created_at).to eq(Time.parse("2022-11-02 15:50:00.281414 -0700"))
    expect(invoice.updated_at).to eq(Time.parse("2022-11-02 15:50:00.281414 -0700"))
  end

end