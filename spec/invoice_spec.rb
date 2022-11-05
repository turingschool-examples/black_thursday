require_relative '../lib/invoice.rb'

RSpec.describe Invoice do
  it 'exists' do
    i = Invoice.new(
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now.to_s,
      :updated_at  => Time.now.to_s
    )

    expect(i).to be_a(Invoice)
  end

  it 'has attributes' do
    i = Invoice.new(
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => created = Time.now.to_s,
      :updated_at  => updated = Time.now.to_s
    )

    expect(i.id).to eq(6)
    expect(i.customer_id).to eq(7)
    expect(i.merchant_id).to eq(8)
    expect(i.status).to eq('pending')
    expect(i.created_at).to eq(Time.parse(created))
    expect(i.updated_at).to eq(Time.parse(updated))
  end
end