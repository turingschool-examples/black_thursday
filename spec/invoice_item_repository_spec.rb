require_relative '../lib/invoice_item.rb'
require_relative '../lib/sales_engine'
require_relative '../lib/modules/repo_queries'


RSpec.describe InvoiceItemRepository do

  it 'exists' do
    invoice_items = InvoiceItemRepository.new

    expect(invoice_items).to be_a(InvoiceItemRepository)
  end

  it 'can find all invoice items' do
    invoice_items = InvoiceItemRepository.new

    expect(invoice_items.data).to eq []
  end

end
