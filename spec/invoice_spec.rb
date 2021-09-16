require 'rspec'
require_relative '../lib/invoice'

describe Invoice do
  before(:each) do
    @invoice = Invoice.new({
                      :id          => 6,
                      :customer_id => 7,
                      :merchant_id => 8,
                      :status      => "pending",
                      :created_at  => Time.now,
                      :updated_at  => Time.now,
                      })
  end

  it "exists" do
    expect(@invoice).to be_an_instance_of(Invoice)
  end
end
