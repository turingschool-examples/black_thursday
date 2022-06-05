require'./lib/invoice_item_repository'
# require'BigDecimal'

RSpec.describe InvoiceItemRepository do
  before :each do

    @salesengine = SalesEngine.new(:invoice_items => "./data/invoice_items.csv")
  end

  it 'exists' do
    expect(@salesengine.details[:invoice_items]).to be_a InvoiceItemRepository
  end
end
