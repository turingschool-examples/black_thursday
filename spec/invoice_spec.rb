require './lib/requirements'

RSpec.describe Invoice do
  let!(:invoice) {Invoice.new({
    :id           => "3452",
    :customer_id  => "679",
    :merchant_id  => "12335690",
    :status       => "pending",
    :created_at   => "2012-03-27 14:54:46 UTC",
    :updated_at   => "2012-03-27 14:54:46 UTC"
  }, nil)}

  it 'is an invoice class' do
    expect(invoice).to be_a(Invoice)
  end

  it "#id returns the invoice id" do
    expect(invoice.id).to eq 3452
    expect(invoice.id.class).to eq Fixnum
  end

  it "#customer_id returns the invoice customer id" do
    expect(invoice.customer_id).to eq 679
    expect(invoice.customer_id.class).to eq Fixnum
  end

  it "#merchant_id returns the invoice merchant id" do
    expect(invoice.merchant_id).to eq 12335690
    expect(invoice.merchant_id.class).to eq Fixnum
  end

  it "#status returns the invoice status" do
    expect(invoice.status).to eq :pending
    expect(invoice.status.class).to eq Symbol
  end

  it "#created_at returns a Time instance for the date the invoice was created" do
    expect(invoice.created_at).to eq Time.parse("2012-03-27 14:54:46 UTC")
    expect(invoice.created_at.class).to eq Time
  end

  it "#updated_at returns a Time instance for the date the invoice was last updated" do
    expect(invoice.updated_at).to eq Time.parse("2012-03-27 14:54:46 UTC")
    expect(invoice.updated_at.class).to eq Time
  end
end