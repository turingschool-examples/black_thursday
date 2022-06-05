require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe CustomerRepository do
  let!(:sales_engine) {SalesEngine.from_csv({:customer => "./data/customer.csv"})}
  let!(:customer_repo) {sales_engine.customer}
  let(:new_customer) {customer_repo.make_customer({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
  })}

  it "exists" do
    expect(customer_repo).to be_instance_of CustomerRepository
  end

  it "can return all customer instances in an array" do
    expect(customer_repo.all).to be_a Array
  end

  xit "can find invoices items by their id" do
    new_customer
    expect(customer_repo.find_by_id(21831)).to be_instance_of Customer
    expect(customer_repo.find_by_id(21831).item_id).to eq(7)
  end

  xit "can find all customers by their item id" do
    new_customer
    expect(customer_repo.find_all_by_item_id(263519844).first).to be_instance_of Customer
    expect(customer_repo.find_all_by_item_id(263519844).first.id).to eq(1)
  end

  xit "can find customers by their invoice id" do
    expect(customer_repo.find_all_by_invoice_id(8).first).to be_instance_of Customer
    expect(customer_repo.find_all_by_invoice_id(8).first.id).to eq(38)
  end

  xit "can update an customer" do
    time = Time.now
    new_customer
    expect(customer_repo.find_by_id(21831)).to be_instance_of Customer
    expect(customer_repo.find_by_id(21831).item_id).to eq(7)
    expect(customer_repo.find_by_id(21831).quantity).to eq(1)
    # expect(customer_repo.find_by_id(21831).updated_at.strftime("%Y-%m-%d %H:%M")).to eq(customer_repo.find_by_id(21831).created_at.strftime("%Y-%m-%d %H:%M"))

    customer_repo.update(21831, {:quantity => 200, :unit_price => "14.99"})
    expect(customer_repo.find_by_id(21831).item_id).to eq(7)
    expect(customer_repo.find_by_id(21831).quantity).to eq(2)
    expect(customer_repo.find_by_id(21831).unit_price).to eq("14.99")
    # expect(customer_repo.find_by_id(21831).updated_at).to eq(time.strftime("%Y-%m-%d %H:%M"))
    # expect(customer_repo.find_by_id(1).updated_at).not_to eq(customer_repo.find_by_id(21831).created_at)
  end

  xit "can delete an invoice" do
    new_customer
    expect(customer_repo.find_by_id(21831)).to be_instance_of Customer
    expect(customer_repo.find_by_id(21831).quantity).to eq(1)
    # expect(customer_repo.find_by_id(1).updated_at).to eq("2014-03-15")
    invoicerepository = double()
    allow(invoicerepository).to receive(:delete).and_return("Deletion complete!")
  end
end
