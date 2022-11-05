require 'simplecov'
SimpleCov.start
require 'rspec'
require './lib/invoice_repository'
require 'pry'

RSpec.describe InvoiceRepository do
  it 'exists and has attributes' do
    invoice_repo = InvoiceRepository.new

    expect(invoice_repo).to be_instance_of(InvoiceRepository)
  end

end