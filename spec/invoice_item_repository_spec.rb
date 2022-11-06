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

  it 'can find an invoice items' do
    invoice_items = InvoiceItemRepository.new

    expect(invoice_items.data).to eq []
  end

  it 'can find an invoice id' do
    ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })
    invoice_items = InvoiceItemRepository.new
    invoice_items.all << ii

    expect(invoice_items.find_by_id(6)).to eq (ii)
  end

  it 'can find all invoices by item id' do
    ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })
    invoice_items = InvoiceItemRepository.new
    invoice_items.all << ii

    expect(invoice_items.find_by_id(6)).to eq (ii)

end
