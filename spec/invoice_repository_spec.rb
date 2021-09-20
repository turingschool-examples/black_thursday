require 'pry'
require './lib/invoice_repository'

RSpec.describe do
  it "exists" do
    invoice_path = './data/invoices.csv'
    invoice_repository = InvoiceRepository.new(invoice_path)
    expect(invoice_repository).to be_an_instance_of(InvoiceRepository)
  end

  it 'can return an array of all known invoices' do
    invoice_path = './data/invoices.csv'
    invoice_repository = InvoiceRepository.new(invoice_path)
    expect(invoice_repository.all[0]).to be_an_instance_of(Invoice)
    expect(invoice_repository.all.count).to eq 4985
  end

  it 'can find invoice by id' do
    invoice_path = './data/invoices.csv'
    invoice_repository = InvoiceRepository.new(invoice_path)
    example_invoice = invoice_repository.all[25]
    expect(invoice_repository.find_by_id(example_invoice.id)).to eq example_invoice
    expect(invoice_repository.find_by_id(999999)).to eq nil
  end

  it 'can find_all_by customer id' do
    invoice_path = './data/invoices.csv'
    invoice_repository = InvoiceRepository.new(invoice_path)
    example_invoice = invoice_repository.all[25]

    expect(invoice_repository.find_all_by_customer_id(example_invoice.customer_id).count).to eq 5
    expect(invoice_repository.find_all_by_customer_id(1234)).to eq([])
  end
end
