require 'csv'
require './lib/invoice'
require './lib/invoice_repository'
require './lib/sales_engine'

RSpec.describe InvoiceRepository do
  before (:each) do
    @se = SalesEngine.from_csv({
            :items     => "./data/items.csv",
            :merchants => "./data/merchants.csv",
            :invoices => './data/invoices.csv'
                              })
  end

  describe "instantiation" do
    it "exists" do
      expect(@se.invoices).to be_a(InvoiceRepository)
      expect(@se.invoices.all[0]).to be_a(Invoice)
    end

    it "has readable attributes" do
      expect(@se.invoices.all.length).to eq(4985)
    end
  end

  it "can find by id" do

    inv = @se.invoices.find_by_id(3452)
    expect(inv.merchant_id).to eq(12335690)
    expect(inv.status).to eq(:pending)
  end

  it "can find_all_by_merchant_id" do
    inv = @se.invoices.find_all_by_merchant_id(12335080)
    expect(inv.length).to eq(7)
  end

  it "can find_all_by_customer_id" do
    inv = @se.invoices.find_all_by_customer_id(300)
    expect(inv.length).to eq(10)
  end

  it "can find all by status" do
    inv = @se.invoices.find_all_by_status(:shipped)
    expect(inv.length).to eq(2839)
    inv = @se.invoices.find_all_by_status(:pending)
    expect(inv.length).to eq(1473)
    inv = @se.invoices.find_all_by_status(:sold)
    expect(inv).to eq []
  end

  it "can create a new invoice" do
    attr = ({
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending"
      })
    @se.invoices.create(attr)
    inv = @se.invoices.find_by_id(4986)
    expect(inv.merchant_id).to eq(8)
    expect(inv.customer_id).to eq(7)
  end

  it "can update an invoice's status" do
    attr = ({
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending"
      })
    @se.invoices.create(attr)
    @se.invoices.update(4986, :success)
    inv = @se.invoices.find_by_id(4986)
    expect(inv.status).to eq(:success)
  end

  it "can delete an invoice by invoice id" do
    attr = ({
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending"
      })
    @se.invoices.create(attr)
    expect(@se.invoices.find_by_id(4986)).to be_a(Invoice)
    @se.invoices.delete(4986)
    expect(@se.invoices.find_by_id(4986)).to eq(nil)
  end

end
