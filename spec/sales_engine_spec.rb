require './lib/sales_engine'

RSpec.describe(SalesEngine) do
  it("#exists") do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv",
    })
    expect(sales_engine).to(be_instance_of(SalesEngine))
  end

  it("#can return an arrray of all items") do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv",
    })
    expect(sales_engine.items).to(be_instance_of(ItemRepository))
  end

  it("#can return an array of all merchants") do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv",
    })
    expect(sales_engine.merchants).to(be_a(MerchantRepository))
    expect(sales_engine.merchants.all).to(be_instance_of(Array))
    expect(sales_engine.merchants.all.length).to(eq(475))
  end

  it("can create an instance of salesanalyst") do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv",
    })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to(be_a(SalesAnalyst))
  end

  it("can create an instance of invoice repository") do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv",
    })
    expect(sales_engine.invoices).to(be_instance_of(InvoiceRepository))
  end

  it("can create an instance of invoice_item repository") do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv",
    })
    expect(sales_engine.invoice_items).to(be_instance_of(InvoiceItemRepository))
  end

  it("can create an instance of transactions") do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv",
    })
    expect(sales_engine.transactions).to(be_instance_of(TransactionRepository))
  end

  it("can create an instance of customer_repository") do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv",
    })
    expect(sales_engine.customers).to(be_instance_of(CustomerRepository))
  end

end
