require './lib/sales_engine'
require 'csv'

RSpec.describe SalesEngine do
  customers     = './data/sample_data/sample_customers.csv'
  invoice_items = './data/sample_data/sample_invoice_items.csv'
  invoices      = './data/sample_data/sample_invoices.csv'
  items         = './data/sample_data/sample_items.csv'
  merchant      = './data/sample_data/sample_merchants.csv'
  transactions  = './data/sample_data/sample_transactions.csv'

  locations = {
    
    item: item_path
    merchant:  merchant_path
    file_name: file_name_path
    }

  sales_engine = SalesEngine.new(locations)
  sales_engine = SalesEngine.from_csv(locations)



  it 'exists' do
    expect(sales_engine).to be_a(SalesEngine)
  end



  it 'exists' do
     se = SalesEngine.from_csv({
       :items     => "./data/items.csv",
       :merchants => "./data/merchants.csv",
       })
    expect(se).not_to eq nil
  end

  xit 'creates an array of item hashes' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    # expect(SalesEngine.item_data).to eq("./data/items.csv")
    # expect(SalesEngine.merchant_data).to eq("./data/merchants.csv")
  end

  xit 'has attributes' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    expect(x).to eq("...")
  end

  xit 'returns the merchants' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
      require "pry"; binding.pry
    expect(se[:merchants]).not_to be nil
  end

end
