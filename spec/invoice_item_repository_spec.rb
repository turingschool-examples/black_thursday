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
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s
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
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s
      })

      ii2 = InvoiceItem.new({
        :id => 7,
        :item_id => 8,
        :invoice_id => 9,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now.to_s,
        :updated_at => Time.now.to_s
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
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s
      })

      ii2 = InvoiceItem.new({
        :id => 7,
        :item_id => 8,
        :invoice_id => 9,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now.to_s,
        :updated_at => Time.now.to_s
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
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s
      })

      ii2 = InvoiceItem.new({
        :id => 7,
        :item_id => 8,
        :invoice_id => 9,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now.to_s,
        :updated_at => Time.now.to_s
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
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s
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
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s
      })

      ii2 = InvoiceItem.new({
        :id => 7,
        :item_id => 8,
        :invoice_id => 9,
        :quantity => 1,
        :unit_price => 1099,
        :created_at => Time.now.to_s,
        :updated_at => Time.now.to_s
        })

    invoice_items = InvoiceItemRepository.new
    invoice_items.all << ii
    invoice_items.all << ii2

    expect(ii.quantity).to eq (1)
    expect(ii.unit_price).to eq (0.1099e0)

    invoice_items.update(6, {
      quantity: 3,
      unit_price: BigDecimal(11.99, 4)
      })

      expect(ii.quantity).to eq (3)
      expect(ii.unit_price).to eq (11.99)
  end

  it 'can delete an invoice item' do
    ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s
      })

    ii2 = InvoiceItem.new({
      :id => 7,
      :item_id => 8,
      :invoice_id => 9,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s.to_s
      })

    invoice_items = InvoiceItemRepository.new
    invoice_items.all << ii
    invoice_items.all << ii2

    expect(invoice_items.all).to eq [ii, ii2]

    invoice_items.delete(7)

    expect(invoice_items.all).to eq [ii]
  end

  it 'can load data' do
    iir = InvoiceItemRepository.new
    file = './data/invoice_items.csv'
    iir.load_data(file)

    expect(iir.all.first).to be_a(InvoiceItem)
    expect(iir.all.all?(InvoiceItem)).to eq(true)
  end
end
