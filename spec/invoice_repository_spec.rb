require 'pry'
require './lib/invoice_repository'
require 'Timecop'

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

  it 'can make a new highest_id' do
      invoice_path = './data/invoices.csv'
      invoice_repository = InvoiceRepository.new(invoice_path)

    expect(invoice_repository.new_highest_id).to eq "4986"
  end

  it 'can make a new invoice' do
    invoices_path = './data/invoices.csv'
    invoice_repository = InvoiceRepository.new(invoices_path)

    expect(invoice_repository.new_highest_id).to eq "4986"

    invoice_repository.create({
      id:          invoice_repository.new_highest_id,
      customer_id: 7,
      merchant_id: 8,
      status:      "pending",
      created_at:  Time.now,
      updated_at:  Time.now
      })

    expect(invoice_repository.new_highest_id).to eq "4987"
    expect(invoice_repository.find_by_id(4986)).not_to eq([])
  end

  before do
    Timecop.freeze(Time.local(1990))
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
                              :updated_at  => "1989-01-01 00:00:00 -0700"
                            })
    expect(invoice_repository.find_by_id(4986).status).to eq "pending"
    expect(invoice_repository.find_by_id(4986).updated_at).to eq("1989-01-01 00:00:00 -0700")
    invoice_repository.update(4986, {:status => "shipped"})
    expect(invoice_repository.find_by_id(4986).status).to eq "shipped"
    # expect(invoice_repository.find_by_id(4986).updated_at).to eq("1990-01-01 00:00:00 -0700")
  end

  after do
    Timecop.return
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

 # it 'can make a new transaction' do
 #   transaction_path = './data/transactions.csv'
 #   transaction_repository = TransactionRepository.new(transaction_path)
 #
 #   expect(transaction_repository.new_highest_id).to eq "4986"
 #
 #   transaction_repository.create({
 #     id: transaction_repository.new_highest_id,
 #     invoice_id: "111",
 #     credit_card_number: "1111111111111111",
 #     credit_card_expiration_date: "1111",
 #     result: "success",
 #     created_at: "now",
 #     updated_at: "just a moment ago"
 #     })
 #
 #     expect(transaction_repository.new_highest_id).to eq "4987"
 #     expect(transaction_repository.find_by_id(4986)).not_to eq([])
 # end
end
