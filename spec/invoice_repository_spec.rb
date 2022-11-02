require './lib/invoice_repository'
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
  let(:invoice2) {Invoice.new({
    :id          => 7,
    :customer_id => 8,
    :merchant_id => 9,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
  })}

  it 'is an instance of a #invoice_repository' do
    expect(invoice_repository).to be_a(InvoiceRepository)
  end

  it 'has a method to find_all_by_customer_id' do
    expect(invoice_repository.find_all_by_customer_id(2)).to eq []

    invoice_repository.all << invoice
    expect(invoice_repository.find_all_by_customer_id(7)).to eq([invoice])
  end

  it 'has a method to find_all_by_merchant_id' do
    invoice_repository.all << invoice
    expect(invoice_repository.find_all_by_merchant_id(8)).to eq([invoice])
  end

  it 'has a method to find_all_by_status' do
    invoice_repository.all << invoice
    expect(invoice_repository.find_all_by_status("pending")).to eq([invoice])

    invoice_repository.all << invoice2
    expect(invoice_repository.find_all_by_status("pending")).to eq([invoice, invoice2])
  end
end