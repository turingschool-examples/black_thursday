require 'bigdecimal'
require_relative 'spec_helper'

RSpec.describe CustomerRepository do

  before(:each) do
    @paths = {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => ".data/transactions.csv",
      :customers => "./data/customers.csv"
    }
    @se = SalesEngine.from_csv(@paths)
  end

  it "exists" do
    cr = @se.customers

    expect(cr).to be_a(CustomerRepository)
  end

  it "calls and reads correct file path" do
    cr = @se.customers
    cr_csv_data = cr.all

    expect(cr_csv_data.class).to eq(Array)
    expect(cr_csv_data.length).to eq(1000)

    data_validation = cr_csv_data.all? do |line|
      line.class == Customer
    end

    expect(data_validation).to be(true)
  end

  it 'can find customer by id' do
    cr = @se.customers
    id = 100
    result = cr.find_by_id(id)

    expect(result.id).to eq(id)
    expect(result.class).to eq(Customer)
  end

  it 'can find all customers by first name' do
    cr = @se.customers
    fragment = "oe"
    result = cr.find_all_by_first_name(fragment)

    expect(result.length).to eq(8)
    expect(result.first.class).to eq(Customer)
  end

  it 'can find all customers by last name' do
    cr = @se.customers
    fragment = "On"
    result = cr.find_all_by_last_name(fragment)

    expect(result.length).to eq(85)
    expect(result.first.class).to eq(Customer)
  end

  it 'can create new instance with attributes' do
    cr = @se.customers
    new_customer = {
          :first_name => "Joan",
          :last_name => "Clarke",
          :created_at => Time.now,
          :updated_at => Time.now
        }

    cr.create(new_customer)
    result = cr.find_by_id(1001)

    expect(result.first_name).to eq("Joan")
  end

  it 'can update an existing InvoiceItem instance' do
    cr = @se.customers
    original_time = cr.find_by_id(1).updated_at
    time_stub = '2021-05-30 11:30:51.343158 -050'
    allow(Time).to receive(:now).and_return(time_stub)
    attributes = {
          :first_name => "Tom",
          :last_name => "Ondricka",
          :created_at => Time.now,
          :updated_at => Time.now
      }

      cr.update(1, attributes)
      result = cr.find_by_id(1)

      expect(result.first_name).to eq("Tom")
      expect(result.unit_price).to eq attributes[:unit_price]
      expect(Time.parse(result.updated_at)).to be > original_time
      result = cr.find_by_id(2000)
      expect(result).to eq nil
    end

  it 'can delete an existing InvoiceItem instance' do
    cr = @se.customers

    old_length = cr.all.length
    result = cr.delete(cr.all[0].id)
    new_length = cr.all.length

    expect(old_length - new_length).to eq(1)
  end
end
