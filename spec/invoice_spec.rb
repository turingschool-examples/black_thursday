# frozen_string_literal: true

# RSpec tests for the Invoice class
require 'RSpec'
require_relative '../lib/invoice.rb'
require 'SimpleCov'
SimpleCov.start

RSpec.describe Invoice do
  invoice = Invoice.new({ id: 1, customer_id: 2307, merchant_id: 24601, status: :pending,
                          created_at: "2022-02-25 17:49:56.871723", updated_at: "2022-02-26 00:51:07 UTC" })

  before(:each) do
    invoice = Invoice.new({ id: 1, customer_id: 2307, merchant_id: 24601, status: :pending,
                            created_at: "2022-02-25 17:49:56.871723", updated_at: "2022-02-26 00:51:07 UTC" })
  end

  it 'Initializes from a hash of relevant information' do
    expect(invoice).to be_a(Invoice)
  end

  it 'Has readable attributes' do
    expect(invoice.id).to eq(1)
    expect(invoice.customer_id).to eq(2307)
    expect(invoice.merchant_id).to eq(24601)
    expect(invoice.status).to eq(:pending)
    expect(invoice.created_at).to eq("2022-02-25 17:49:56.871723")
  end

  it 'Has writable attributes' do
    invoice.status = :shipped
    expect(invoice.status).to eq(:shipped)

    invoice.updated_at = "2022-02-26 03:17:26 UTC"
    expect(invoice.updated_at).to eq("2022-02-26 03:17:26 UTC")

    expect { invoice.id = 4 }.to raise_error(NoMethodError)
  end
end
