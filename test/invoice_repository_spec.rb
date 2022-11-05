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
                          created_at: "2009-02-07",
                          updated_at: "2014-03-15"
                          })

    expect(invoice_repo1).to be_instance_of(InvoiceRepository)
    expect(inv_creation).to be_instance_of(Invoice)
  end

end