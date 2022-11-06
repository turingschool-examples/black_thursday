require './lib/invoice_repository'
require './lib/invoice'
require 'rspec'
require './lib/item'
require './lib/item_repository'
require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/merchant'
require 'csv'


RSpec.describe InvoiceRepository do
  let!(:invoice_repository) {InvoiceRepository.new('./data/invoices.csv', nil)}

  it 'is a invoice repository class' do
    expect(invoice_repository).to be_a(InvoiceRepository)
  end

  it "#all returns all invoices" do
      expect(invoice_repository.all.length).to eq 4985
    end

  it "#find_by_id returns an invoice associated to the given id" do
    invoice_id = 3452
    expected = invoice_repository.find_by_id(invoice_id)

    expect(expected.id).to eq invoice_id
    expect(expected.merchant_id).to eq 12335690
    expect(expected.customer_id).to eq 679
    expect(expected.status).to eq :pending

    invoice_id = 5000
    expected = invoice_repository.find_by_id(invoice_id)

    expect(expected).to eq nil
  end

  it "#find_all_by_customer_id returns all invoices associated with given customer" do
    # require 'pry'; binding.pry
   expect(invoice_repository.find_all_by_customer_id(300).length).to eq 10
   expect(invoice_repository.find_all_by_customer_id(1000)).to eq([])

  end

  it "#find_all_by_merchant_id returns all invoices associated with given merchant" do
    # require 'pry'; binding.pry
   expect(invoice_repository.find_all_by_merchant_id(12335080).length).to eq 7
   expect(invoice_repository.find_all_by_merchant_id(1000)).to eq([])
    
  end

  it "#find_all_by_status returns all invoices associated with given status" do
    status = :shipped
    expect(invoice_repository.find_all_by_status(status).length).to eq 2839

    # expect(expected.length).to eq 2839

    status = :pending
    expect(invoice_repository.find_all_by_status(status).length).to eq 1473

    # expect(expected.length).to eq 1473

    status = :sold
    expect(invoice_repository.find_all_by_status(status)).to eq []

    # expect(expected).to eq []
  end

  it "#create creates a new invoice instance" do
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    invoice_repository.create(attributes)
    expected = invoice_repository.find_by_id(4986)
    expect(expected.merchant_id).to eq 8
  end

  it "#update updates an invoice" do
    # require 'pry'; binding.pry
    original_time = invoice_repository.find_by_id(4985).updated_at
    attributes = {
      status: :success
    }
    invoice_repository.update(4985, attributes)
    invoice_repository.find_by_id(4985)
    expect(invoice_repository.find_by_id(4985).status).to eq :success
    # require 'pry'; binding.pry
    expect(invoice_repository.find_by_id(4985).customer_id).to eq 999
    expect(invoice_repository.find_by_id(4985).updated_at).not_to be original_time
  end

  it "#update cannot update id, customer_id, merchant_id, or created_at" do
    attributes = {
      id: 5000,
      customer_id: 2,
      merchant_id: 3,
      created_at: Time.now
    }
    invoice_repository.update(4985, attributes)
    expected = invoice_repository.find_by_id(5000)
    expect(expected).to eq nil
    invoice_repository.find_by_id(4985)
    expect(invoice_repository.find_by_id(4985).customer_id).not_to eq attributes[:customer_id]
    expect(invoice_repository.find_by_id(4985).merchant_id).not_to eq attributes[:merchant_id]
    expect(invoice_repository.find_by_id(4985).created_at).not_to eq attributes[:created_at]
  end

  it "#update on unknown invoice does nothing" do
    invoice_repository.update(5000, {})
  end

  it "#delete deletes the specified invoice" do
    invoice_repository.delete(4985)
    expected = invoice_repository.find_by_id(4985)
    expect(expected).to eq nil
  end

  it "#delete on unknown invoice does nothing" do
    invoice_repository.invoices.delete(5000)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
  

# all - returns an array of all known Invoice instances
# find_by_id - returns either nil or an instance of Invoice with a matching ID
# find_all_by_customer_id - returns either [] or one or more matches which have a matching customer ID
# find_all_by_merchant_id - returns either [] or one or more matches which have a matching merchant ID
# find_all_by_status - returns either [] or one or more matches which have a matching status
# create(attributes) - create a new Invoice instance with the provided attributes. The new Invoice’s id should be the current highest Invoice id plus 1.
# update(id, attribute) - update the Invoice instance with the corresponding id with the provided attributes. Only the invoice’s status can be updated. This method will also change the invoice’s updated_at attribute to the current time.
# delete(id) - delete the Invoice instance with the corresponding id
end