require 'rspec'
require './lib/sales_engine'
require './lib/sales_analyst'
require './lib/items'
require './lib/items_repo'
require './lib/merchants'
require './lib/merchants_repo'
require './lib/invoices'
require './lib/invoices_repo'
require './lib/invoice_item_repo'
require './lib/invoice_item'
require './lib/transaction_repo'
require './lib/transaction'
require './lib/customer_repo'
require './lib/customer'

RSpec.describe SalesEngine do

  se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoices  => "./data/invoices.csv",
  :invoice_items => "./data/invoice_items.csv",
  :transactions => "./data/transactions.csv",
  :customers => "./data/customers.csv"
  })

  context 'it exists' do
    it 'exists' do
      expect(se).to be_instance_of(SalesEngine)
    end
  end

  context 'methods' do
    it 'has attributes' do
      expect(se.items).to be_instance_of(ItemRepo)
      expect(se.merchants).to be_instance_of(MerchantRepo)
      expect(se.invoices).to be_instance_of(InvoiceRepo)
      expect(se.invoice_items).to be_instance_of(InvoiceItemRepo)
      expect(se.transactions).to be_instance_of(TransactionRepo)
      expect(se.customers).to be_instance_of(CustomerRepo)
      expect(se.analyst).to be_instance_of(SalesAnalyst)
    end
  end

end
