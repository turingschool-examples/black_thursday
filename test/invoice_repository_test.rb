require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe InvoiceRepository do
  let!(:invoice_repo) {InvoiceRepository.new("new")}

  it "exists" do
    expect(invoice_repo).to be_instance_of InvoiceRepository
  end
end
