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

      ii2 = InvoiceItem.new({
        :id => 7,
        :item_id => 8,
        :invoice_id => 9,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
        })
    invoice_items = InvoiceItemRepository.new
    invoice_items.all << ii
    invoice_items.all << ii2

    expect(invoice_items.find_all_by_item_id(7)).to eq ([ii])
    expect(invoice_items.find_all_by_item_id(9)).to eq ([])
  end

  it 'can find all invoices by invoice id' do
    ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })

      ii2 = InvoiceItem.new({
        :id => 7,
        :item_id => 8,
        :invoice_id => 9,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
        })
    invoice_items = InvoiceItemRepository.new
    invoice_items.all << ii
    invoice_items.all << ii2

    expect(invoice_items.find_all_by_invoice_id(8)).to eq ([ii])
    expect(invoice_items.find_all_by_invoice_id(10)).to eq ([])
  end

  it 'can create a new invoice item' do
    ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })

      ii2 = InvoiceItem.new({
        :id => 7,
        :item_id => 8,
        :invoice_id => 9,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
        })
    invoice_items = InvoiceItemRepository.new
    invoice_items.all << ii
    invoice_items.all << ii2

    new_invoice_item = invoice_items.create({
      :id => 7,
      :item_id => 8,
      :invoice_id => 9,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })

      expect(new_invoice_item.id).to be(8)
  end

  it 'can update an invoice item' do
    ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })

      ii2 = InvoiceItem.new({
        :id => 7,
        :item_id => 8,
        :invoice_id => 9,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
        })

    invoice_items = InvoiceItemRepository.new
    invoice_items.all << ii
    invoice_items.all << ii2

    expect(ii.quantity).to eq (1)
    expect(ii.unit_price).to eq (10.99)

    invoice_items.update(7, {
      quantity: 3,
      unit_price: BigDecimal(11.99, 4)
      })

      expect(ii.quantity).to eq (1)
      expect(ii.unit_price).to eq (10.99)
  end
end
