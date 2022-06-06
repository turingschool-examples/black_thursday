require "./lib/invoice"
require "./lib/invoice_repository"
require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/item"
require "./lib/merchant_repository"
require "./lib/merchant"

RSpec.describe Invoice do
  before(:each) do
  @invoice = Invoice.new ({
    :id           => 2,
    :customer_id  => 1,
    :merchant_id  => 12334753,
    :status       => "shipped",
    :created_at   => "2012-11-23",
    :updated_at   => "2013-04-14",
    })
  end

  it "exist" do
    expect(@invoice).to be_a(Invoice)
  end

  it "has attributes" do
    expect(@invoice.id).to eq(2)
    expect(@invoice.customer_id).to eq(1)
    expect(@invoice.merchant_id).to eq(12334753)
    expect(@invoice.status).to eq(:shipped)
    expect(@invoice.created_at).to eq(Time.parse("2012-11-23"))
    expect(@invoice.updated_at).to eq(Time.parse("2013-04-14"))
  end
end
