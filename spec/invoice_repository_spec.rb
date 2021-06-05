require 'bigdecimal'
require_relative 'spec_helper'

RSpec.describe InvoiceRepository do

  before(:each) do
    @paths = {
      :invoices => "./data/invoices.csv",
      :merchants => "./data/merchants.csv"
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
      line.class == Item
    end

    expect(data_validation).to be(true)
  end

  it 'can find all invoices by a invoice_id' do
    invoice_id = 3452
    result = engine.invoices.find_by_id(invoice_id)


    expect(result.id).to eq(invoice_id)
    expect(result.merchant_id).to eq(12335690)
    expect(result.customer_id).to eq(679)
    expect(result.result.status).to eq(:pending)
  end

  it 'can find all invoice by a given customer_id' do
    customer_id = 300
    result = engine.invoices.find_all_by_customer_id(customer_id)

    expect(result.length).to eq(10)
  end


  it 'can find all invoice by a given merchant_id' do
    merchant_id = 12335080
    result = engine.invoices.find_all_by_merchant_id(merchant_id)

    expect(result.length).to eq(7)
  end

  it 'can find all by status' do
    status = :shipped
    result = engine.invoices.find_all_by_status(status)

    expect(result.length).to eq(2839)
    status = :pending
    result = engine.invoices.find_all_by_status(status)

    expect(result.length).to eq(1473)
    status = :sold
    result = engine.invoices.find_all_by_status(status)

    expect(result.length).to eq([])
  end

  it 'can create new instance with attributes' do
    ir = @se.invoices
    new_item = {
          :id => create_new_id,
          :customer_id => 7,
          :merchant_id => 8,
          :status => "pending",
          :created_at => Time.now,
          :updated_at => Time.now
        }

    engine.invoices.create(attributes)
    result = engine.invoices.find_by_id(4986)

    expect(result.merchant_id).to eq(8)      
  end

  it 'can update an existing Item instance name' do
    ir = @se.invoices
    time_stub = '2021-05-30 11:30:51.343158 -050'
    allow(Time).to receive(:now).and_return(time_stub)
    item_update = {
                :name => 'Pen',
                :description => 'Pentel R.S.V.P. Fine' ,
                :unit_price => BigDecimal(5.99, 3)
              }

    ir.update(ir.all[0].id, item_update)
    result = ir.all[-1]

    expect(result.name).to eq(item_update[:name])
    expect(result.description).to eq(item_update[:description])
    expect(result.unit_price).to eq(item_update[:unit_price])
    expect(result.updated_at).to eq(Time.now)

  end

  it 'can delete an existing Item instance' do
    ir = @se.invoices

    old_length = ir.all.length
    result = ir.delete(ir.all[0].id)
    new_length = ir.all.length

    expect(old_length - new_length).to eq(1)
  end

  it 'can find all by description' do
    ir = @se.invoices
    result = ir.find_all_with_description('hoop'.upcase)

    expect(result.class).to eq(Array)
    expect(result.length).to eq(9)
  end

  it 'can find all by price' do
    ir = @se.invoices
    result = ir.find_all_by_price(BigDecimal(25))

    expect(result.class).to eq(Array)
    expect(result.length).to eq(79)
  end

  it 'can find all by price range' do
    ir = @se.invoices

    test_range = (0..10.0)
    result = ir.find_all_by_price_in_range(test_range)

    expect(result.class).to eq(Array)
    expect(result.length).to eq(302)
  end

  it 'can find all merchants by merchant id' do
    ir = @se.invoices

    result = ir.find_all_by_merchant_id(12334280)

    expect(result.class).to eq(Array)
    expect(result.length).to eq(3)
  end
end
