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

  it 'can find_all_by merchant id' do
    invoice_path = './data/invoices.csv'
    invoice_repository = InvoiceRepository.new(invoice_path)
    example_invoice = invoice_repository.all[25]

    expect(invoice_repository.find_all_by_merchant_id(example_invoice.merchant_id).count).to eq 16
    expect(invoice_repository.find_all_by_merchant_id(000000)).to eq([])
  end

  it 'can find_all_by status' do
    invoice_path = './data/invoices.csv'
    invoice_repository = InvoiceRepository.new(invoice_path)

    expect(invoice_repository.find_all_by_status("returned").count).to eq 673
    expect(invoice_repository.find_all_by_status("went_overboard")).to eq([])
  end

  it 'can create a invoice with given attributes' do
    invoices_path = './data/invoices.csv'
    invoice_repository = InvoiceRepository.new(invoices_path)
    expect(invoice_repository.find_by_id(4986)).to eq(nil)
    invoice_repository.create({
                              :id          => 4986,
                              :customer_id => 7,
                              :merchant_id => 8,
                              :status      => "pending",
                              :created_at  => Time.now,
                              :updated_at  => Time.now,
                            })
    expect(invoice_repository.find_by_id(4986)).not_to eq(nil)
    expect(invoice_repository.all.last.id).to eq(4986)
  end

  it 'can update invoice attributes using ID' do
    invoice_path = './data/invoices.csv'
    invoice_repository = InvoiceRepository.new(invoice_path)
    invoice_repository.create({
                              :id          => 4986,
                              :customer_id => 7,
                              :merchant_id => 8,
                              :status      => "pending",
                              :created_at  => Time.now,
                              :updated_at  => Time.now.to_i,
                            })
    start_time = (invoice_repository.find_by_id(4986)).updated_at
    expect(invoice_repository.find_by_id(4986).status).to eq "pending"
    invoice_repository.update(4986, {:status => "shipped"})
    sleep 1

    update_time = (invoice_repository.find_by_id(4986)).updated_at

    expect(invoice_repository.find_by_id(4986).status).to eq "shipped"
    expect((update_time - start_time).round(2)).to be_within(0.1).of(1.00)
  end

  it 'can delete a invoice by ID' do
    invoices_path = './data/invoices.csv'
    invoice_repository = InvoiceRepository.new(invoices_path)
    invoice_repository.create({
                              :id          => 4986,
                              :customer_id => 7,
                              :merchant_id => 8,
                              :status      => "pending",
                              :created_at  => Time.now,
                              :updated_at  => Time.now,
                            })

    expect(invoice_repository.all.count).to eq 4986
    invoice_repository.delete(4986)
    expect(invoice_repository.all.count).to eq 4985
 end
end
