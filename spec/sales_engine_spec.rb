require "./lib/sales_engine"

RSpec.describe SalesEngine do
  it "exists" do
    sales_engine = SalesEngine.from_csv({
      :items          => "./data/items.csv",
      :merchants      => "./data/merchants.csv",
      :invoices       => "./data/invoices.csv",
      :invoice_items  => "./data/invoice_items.csv",
      :transactions   => "./data/transactions.csv",
      :customers      => "./data/customers.csv"
    })
    expect(sales_engine).to be_instance_of SalesEngine
  end

  it "can return an array of all items" do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items  => "./data/invoice_items.csv",
      :transactions   => "./data/transactions.csv",
      :customers      => "./data/customers.csv"
    })
    expect(sales_engine.items).to be_instance_of ItemRepository
  end

  it "can return an array of all merchants" do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items  => "./data/invoice_items.csv",
      :transactions   => "./data/transactions.csv",
      :customers      => "./data/customers.csv"
    })
    expect(sales_engine.merchants).to be_instance_of MerchantRepository
  end

  it "can return an array of all invoices" do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items  => "./data/invoice_items.csv",
      :transactions   => "./data/transactions.csv",
      :customers      => "./data/customers.csv"
    })
    expect(sales_engine.invoices).to be_instance_of InvoiceRepository
  end
end
