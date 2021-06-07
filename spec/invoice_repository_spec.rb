require 'bigdecimal'
require_relative 'spec_helper'

RSpec.describe InvoiceRepository do

  before(:each) do
    @paths = {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    }
    @se = SalesEngine.from_csv(@paths)
  end

  it "exists" do
    ir = @se.invoices

    expect(ir).to be_a(InvoiceRepository)
  end

  it "calls and reads correct file path" do
    ir = @se.invoices
    ir_csv_data = ir.all

    expect(ir_csv_data.class).to eq(Array)
    expect(ir_csv_data.length).to eq(4985)

    data_validation = ir_csv_data.all? do |line|
      line.class == Invoice
    end

    expect(data_validation).to be(true)
  end

  it 'can find all invoices by id' do
    ir = @se.invoices
    invoice_id = 3452
    result = ir.find_by_id(invoice_id)

    expect(result.id).to eq(invoice_id)
    expect(result.merchant_id).to eq(12335690)
    expect(result.customer_id).to eq(679)
    expect(result.status).to eq(:pending)
  end

  it 'can find all invoice by a given customer_id' do
    ir = @se.invoices
    customer_id = 300
    result = ir.find_all_by_customer_id(customer_id)

    expect(result.length).to eq(10)
  end


  it 'can find all invoice by a given merchant_id' do
    ir = @se.invoices
    merchant_id = 12335080
    result = ir.find_all_by_merchant_id(merchant_id)

    expect(result.length).to eq(7)
  end

  it 'can find all by status' do
    ir = @se.invoices
    status = :shipped
    result = ir.find_all_by_status(status)

    expect(result.length).to eq(2839)
    status = :pending
    result = ir.find_all_by_status(status)

    expect(result.length).to eq(1473)
    status = :sold
    result = ir.find_all_by_status(status)

    expect(result.length).to eq(0)
  end

  it 'can create new instance with attributes' do
    ir = @se.invoices
    new_invoice = {
          :id => ir.create_new_id,
          :customer_id => 7,
          :merchant_id => 8,
          :status => "pending",
          :created_at => Time.now,
          :updated_at => Time.now
        }

    ir.create(new_invoice)
    result = ir.find_by_id(4986)

    expect(result.merchant_id).to eq(8)
  end

  it 'can update an existing Invoice instance' do
    ir = @se.invoices
    original_time = ir.find_by_id(4985).updated_at
    time_stub = '2021-05-30 11:30:51.343158 -050'
    allow(Time).to receive(:now).and_return(time_stub)
    attributes = {
        id: 5000,
        customer_id: 2,
        merchant_id: 3,
        status: :success,
        created_at: Time.now,
        updated_at: Time.now
      }

      ir.update(4985, attributes)
      result = ir.find_by_id(4985)

      expect(result.status).to eq :success
      expect(Time.parse(result.updated_at)).to be > original_time
      expect(result.customer_id).not_to eq attributes[:customer_id]
      expect(result.customer_id).not_to eq attributes[:merchant_id]
      # expect(result.created_at).not_to eq (Time.parse(attributes[:created_at].to_s))

      result = ir.find_by_id(5000)
      expect(result).to eq nil

  end

  it 'can delete an existing Invoice instance' do
    ir = @se.invoices

    old_length = ir.all.length
    result = ir.delete(ir.all[0].id)
    new_length = ir.all.length

    expect(old_length - new_length).to eq(1)
  end
end
