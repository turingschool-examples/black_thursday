require "./lib/invoice"
require "./lib/invoice_repository"
require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/item"
require "./lib/merchant_repository"
require "./lib/merchant"
require "./lib/customer"

RSpec.describe Customer do
  let(:c) {Customer.new({
    :id           => 6,
    :first_name   => "Joan",
    :last_name    => "Clarke",
    :created_at   => Time.now.round,
    :updated_at   => Time.now.round
     })}
  it "exists" do
    expect(c).to be_a(Customer)
  end

  it 'has an id' do
    expect(c.id).to be_a(Integer)
    expect(c.id).to eq(6)
  end

  it 'has a first name' do
    expect(c.first_name).to be_a(String)
    expect(c.first_name).to eq("Joan")
  end

  it 'has a last name' do
    expect(c.last_name).to be_a(String)
    expect(c.last_name).to eq("Clarke")
  end

  it 'has a created_at time saved' do
    expect(c.created_at).to be_a(Time)
    expect(c.created_at).to eq(Time.now.round)
  end

  it 'has a updated_at time saved' do
    expect(c.updated_at).to be_a(Time)
    expect(c.updated_at).to eq(Time.now.round)
  end

end
