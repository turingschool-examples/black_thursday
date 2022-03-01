require './lib/sales_engine'

describe SalesEngine do
    se = SalesEngine.from_csv({
            :items     => "./data/items.csv",
            :merchants => "./data/merchants.csv",
            :invoices => './data/invoices.csv',
            :customers => './data/customers.csv'
                              })

  it 'exists' do
    expect(se.items).to be_an_instance_of(ItemRepository)
    expect(se.merchants).to be_an_instance_of(MerchantRepository)
    expect(se.invoices).to be_an_instance_of(InvoiceRepository)
  end



end
