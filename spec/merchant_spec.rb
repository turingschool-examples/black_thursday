require 'rspec'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'

RSpec.describe do
  it 'exists' do
    m = Merchant.new({:id => 5, :name => "Turing School"})

    expect(m).to be_a(Merchant)
  end

  it 'has a name and id' do
      m = Merchant.new({:id => 5, :name => "Turing School"})

      expect(m.id).to eq(5)
      expect(m.name).to eq("Turing School")
  end

  it 'finds all the items per merchant' do
    sales_engine = SalesEngine.from_csv(
      :items     => './data/test_data/items_test2.csv',
      :merchants => './data/test_data/merchant_test2.csv'
      )
      m2 = sales_engine.merchants.all[1]

      expect(m2.items.length).to eq(4)
  end

  it 'can return the total money amount of an invoice' do
    sales_engine = SalesEngine.from_csv(
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv',
      :invoice_items => './data/invoice_items.csv',
      :transactions => './data/transactions.csv',
      :customers => './data/customers.csv'
      )

      m = sales_engine.merchants.all[0]

      expect(m.class).to eq(Merchant)
      expect(m.invoice_total(1)).to eq(21_067.77)
  end

  it 'can return an array of invoice totals for each of its invoices ' do
    sales_engine = SalesEngine.from_csv(
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices  => './data/invoices.csv',
      :invoice_items => './data/invoice_items.csv',
      :transactions => './data/transactions.csv',
      :customers => './data/customers.csv'
      )

      m = sales_engine.merchants.all[333]

      expect(m.total_revenue).to eq(0.1263009e6)
  end
end
