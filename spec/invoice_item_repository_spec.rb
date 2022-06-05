require'./lib/invoice_item_repository'
# require'BigDecimal'

RSpec.describe InvoiceItemRepository do
  before :each do

    @salesengine = InvoiceItemRepository.new(:invoice_items => "./data/invoice_items.csv")
  end

  it 'exists' do
    expect(@salesengine).to be_a InvoiceItemRepository
  end
end
