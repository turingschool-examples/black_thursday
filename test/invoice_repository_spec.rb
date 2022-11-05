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
    expect(inv_creation.status).to eq(:pending)
    expect(inv_creation.created_at).to be_instance_of(Time)
    expect(inv_creation.updated_at).to be_instance_of(Time)
  end

  it 'the repository can return an array of all invoices' do
    invoice_repo1 = InvoiceRepository.new
    inv_creation1 = invoice_repo1.create ({
                          id: 1,
                          customer_id: 1,
                          merchant_id: 12335938,
                          status: "pending",
                          created_at: Time.now,
                          updated_at: Time.now
                          })
    inv_creation2 = invoice_repo1.create ({
                          id: 3,
                          customer_id: 5,
                          merchant_id: 12333135231,
                          status: "pending",
                          created_at: Time.now,
                          updated_at: Time.now
                          })
    inv_creation3 = invoice_repo1.create ({
                          id: 6,
                          customer_id: 8,
                          merchant_id: 1233635,
                          status: "shipped",
                          created_at: Time.now,
                          updated_at: Time.now
                          })
    expect(invoice_repo1.all).to eq([inv_creation1, inv_creation2, inv_creation3])
  end

  it 'repository can find the invoices by id' do
    invoice_repo1 = InvoiceRepository.new
    inv_creation1 = invoice_repo1.create ({
                          id: 1,
                          customer_id: 1,
                          merchant_id: 12335938,
                          status: "pending",
                          created_at: Time.now,
                          updated_at: Time.now
                          })
    expect(invoice_repo1.find_by_id(1)).to be_instance_of(Invoice)
    expect(invoice_repo1.find_by_id(625)).to be_nil
  end

  it 'repository can find all invoices by customer id' do
    invoice_repo1 = InvoiceRepository.new
    inv_creation1 = invoice_repo1.create ({
                          id: 1,
                          customer_id: 1,
                          merchant_id: 12335938,
                          status: "pending",
                          created_at: Time.now,
                          updated_at: Time.now
                          })
    inv_creation2 = invoice_repo1.create ({
                          id: 3,
                          customer_id: 5,
                          merchant_id: 12333135231,
                          status: "pending",
                          created_at: Time.now,
                          updated_at: Time.now
                          })
    expect(invoice_repo1.find_all_by_customer_id(1)).to eq([inv_creation1])
    expect(invoice_repo1.find_all_by_customer_id(5)).to eq([inv_creation2])
    expect(invoice_repo1.find_all_by_customer_id(18)).to eq([])
  end
end