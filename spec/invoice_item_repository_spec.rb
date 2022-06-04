require'./lib/invoice_item_repository'
# require'BigDecimal'

RSpec.describe InvoiceItemRepository do
  before :each do

    @se = SalesEngine.from_csv(:invoice_items => "./data/invoice_items.csv")
  end

  it 'exists' do
    expect(@se.details[:invoice_items]).to be_a InvoiceItemRepository
  end
end
