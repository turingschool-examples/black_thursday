require './lib/invoicerepository'
require './lib/invoice'

RSpec.describe InvoiceRepository do
  let(:invoice_repository) {InvoiceRepository.new}
  let(:invoice) {Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
  })}
  

  it 'is an instance of a #invoice_repository' do
    expect(invoice_repository).to be_a(InvoiceRepository)
  end

  it 'has a method to find_all_by_customer_id' do
    
  end

  it 'has a method to find_all_by_merchant_id' do
    
  end

  it 'has a method to find_all_by_status' do
   
  end
end