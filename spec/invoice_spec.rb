require "./lib/invoice"
require "rspec"
RSpec.describe Invoice do
  it "exists" do
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => 2009-02-07,
      :updated_at  => 2014-03-15})
    expect(i).to be_a(Invoice)
  end

  it "has readable attributes" do
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => "2009-02-07",
      :updated_at  => "2014-03-15"})
    expect(i.id).to eq(6)
    expect(i.customer_id).to eq(7)
    expect(i.merchant_id).to eq(8)
    expect(i.status).to eq("pending")
    expect(i.created_at).to eq("2009-02-07")
    expect(i.updated_at).to eq("2014-03-15")
  end
end
