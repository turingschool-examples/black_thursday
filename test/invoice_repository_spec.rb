require 'simplecov'
SimpleCov.start
require 'rspec'
require './lib/invoice_repository'
require 'pry'

RSpec.describe InvoiceRepository do
  it 'exists and has attributes' do
    invoice_repo1 = InvoiceRepository.new
    inv_creation = invoice_repo1.create ({
                          id: 1,
                          customer_id: 1,
                          merchant_id: 12335938,
                          status: "pending",
                          created_at: Time.now,
                          updated_at: Time.now
                          })

    expect(invoice_repo1).to be_instance_of(InvoiceRepository)
    expect(inv_creation).to be_instance_of(Invoice)
    expect(inv_creation.id).to eq(1)
    expect(inv_creation.customer_id).to eq(1)
    expect(inv_creation.merchant_id).to eq(12335938)
    expect(inv_creation.status).to eq("pending")
    expect(inv_creation.created_at).to be_instance_of(Time)
    expect(inv_creation.updated_at).to be_instance_of(Time)
  end

end