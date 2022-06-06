require './lib/invoice_repository'
require './lib/invoice'


RSpec.describe InvoiceRepository do
  before :each do
    @invoice_repository = InvoiceRepository.new("./data/invoices.csv")
  end

  it 'exists' do
    expect(@invoice_repository).to be_a InvoiceRepository
  end

  it 'returns an array of invoice instances' do
    expect(@invoice_repository.all).to be_a Array
    expect(@invoice_repository.all.count).to eq(4985)

  end

  it 'can find by id' do
    expect(@invoice_repository.find_by_id(263395237)).to eq(@invoice_repository.all.first)
    expect(@invoice_repository.find_by_id(1233)).to eq(nil)
    expect(@invoice_repository.find_by_id(263395237)).to be_a(Invoice)
  end



end
