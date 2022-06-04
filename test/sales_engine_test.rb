require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe SalesEngine do
  let!(:sales_engine) {SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
  })}
  let!(:sales_engine_inv) {SalesEngine.from_csv({:invoices => "./data/invoices.csv"})}
  let!(:invoice_repo) {sales_engine_inv.invoices}

  it 'exists' do
<<<<<<< HEAD
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
      })

=======
>>>>>>> c06c19d4a02da98799ed6797763d95f47757c008
    expect(sales_engine).to be_instance_of(SalesEngine)
  end

  it 'can return merchant repository' do
<<<<<<< HEAD
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"

      })

=======
>>>>>>> c06c19d4a02da98799ed6797763d95f47757c008
    merchant_repo = sales_engine.merchants

    expect(merchant_repo).to be_instance_of(MerchantRepository)
  end

  it 'can return item repository' do
<<<<<<< HEAD
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
      })

=======
>>>>>>> c06c19d4a02da98799ed6797763d95f47757c008
    item_repo = sales_engine.items

    expect(item_repo).to be_instance_of(ItemRepository)
  end

  it 'can return invoice repository' do
    expect(invoice_repo).to be_instance_of(InvoiceRepository)
  end

end
