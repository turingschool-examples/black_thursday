require_relative 'spec_helper'

RSpec.describe SalesEngine do
  it 'can read from csv class method' do
    paths = {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    }
    se = SalesEngine.from_csv(paths)

    expect(se.merchants.class).to eq(MerchantRepository)
    expect(se.merchants.all.class).to eq(Array)
    expect(se.merchants.all.length).to eq(475)

    expect(se.items.class).to eq(ItemRepository)
    expect(se.items.all.class).to eq(Array)
    expect(se.items.all.length).to eq(1367)

    expect(se.invoices.class).to eq(InvoiceRepository)
    expect(se.invoices.all.class).to eq(Array)
    expect(se.invoices.all.length).to eq(4985)

    expect(se.invoice_items.class).to eq(InvoiceItemRepository)
    expect(se.invoice_items.all.class).to eq(Array)
    expect(se.invoice_items.all.length).to eq(21830)

    expect(se.transactions.class).to eq(TransactionRepository)
    expect(se.transactions.all.class).to eq(Array)
    expect(se.transactions.all.length).to eq(4985)

    expect(se.customers.class).to eq(CustomerRepository)
    expect(se.customers.all.class).to eq(Array)
    expect(se.customers.all.length).to eq(1000)

  end

end
