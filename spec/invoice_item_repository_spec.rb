require './lib/sales_engine'

RSpec.describe 'ItemRepository' do
  describe '#initialize' do
    it 'creates an instance of ItemRepository' do
      se = SalesEngine.from_csv(
        invoice_items: './data/invoice_items.csv'
      )

      iir = se.invoice_items

      expect(iir.class).to eq(InvoiceItemRepository)
    end
    it 'is created with an array of items' do
      se = SalesEngine.from_csv(
        invoice_items: './data/invoice_items.csv'
      )

      iir = se.invoice_items

      expect(iir.all.class).to eq(Array)
      expect(iir.all[0].class).to eq(InvoiceItem)
    end
  end
  describe '#all' do
    it 'returns an array of all items created so far' do
      se = SalesEngine.from_csv(
        invoice_items: './data/invoice_items.csv'
      )

      iir = se.invoice_items
      expect(iir.all[3].item_id).to eq(263_542_298)
    end
  end
  describe '#find_by_id' do
    it 'returns an instance of an item' do
      se = SalesEngine.from_csv(
        invoice_items: './data/invoice_items.csv'
      )

      iir = se.invoice_items

      expect(iir.find_by_id(460).item_id).to eq(263_421_679)
    end
    it 'returns nil if no item has matching id' do
      se = SalesEngine.from_csv(
        invoice_items: './data/invoice_items.csv'
      )

      iir = se.invoice_items

      expect(iir.find_by_id(123_000)).to eq(nil)
    end
  end
  describe '#find_all_by_item_id' do
    it 'returns the inventory item instance with a matching item id' do
      se = SalesEngine.from_csv(
        invoice_items: './data/invoice_items.csv'
      )

      iir = se.invoice_items

      expect(iir.find_all_by_item_id(263_511_296).length).to eq(25)
    end
    it 'returns an empty array if the item id is not found' do
      se = SalesEngine.from_csv(
        invoice_items: './data/invoice_items.csv'
      )

      iir = se.invoice_items

      expect(iir.find_all_by_item_id(363_567_475)).to eq([])
    end
  end
  describe '#find_all_by_invoice_id' do
    it 'returns the inventory item instance with a matching invoice id' do
      se = SalesEngine.from_csv(
        invoice_items: './data/invoice_items.csv'
      )

      iir = se.invoice_items

      expect(iir.find_all_by_invoice_id(2).length).to eq(4)
    end
    it 'returns an empty array if the invoice id is not found' do
      se = SalesEngine.from_csv(
        invoice_items: './data/invoice_items.csv'
      )

      iir = se.invoice_items

      expect(iir.find_all_by_invoice_id(36_000)).to eq([])
    end
  end
  describe '#create' do
    it 'creates an instance of an invoice item' do
      se = SalesEngine.from_csv(
        invoice_items: './data/invoice_items.csv'
      )

      iir = se.invoice_items
      invoice_item = iir.create(
        item_id: 263_519_844,
        invoice_id: 4_986,
        quantity: 3,
        unit_price: 136.35
      )

      expect(invoice_item.class).to eq(InvoiceItem)
    end
  end
  describe '#update' do
    it 'changes the attributes of an invoice item identified by its id' do
      se = SalesEngine.from_csv(
        invoice_items: './data/invoice_items.csv'
      )

      iir = se.invoice_items
      iir.update(
        21_830,
        quantity: 5,
        unit_price: 586.55
      )
      expect(iir.find_by_id(21_830).quantity).to eq(5)
      expect(iir.find_by_id(21_830).unit_price_to_dollars).to eq(586.55)
    end
  end
  describe '#delete' do
    it 'changes the attributes of an item identified by its id' do
      se = SalesEngine.from_csv(
        invoice_items: './data/invoice_items.csv'
      )

      iir = se.invoice_items
      iir.delete(21_830)
      expect(iir.find_by_id(21_830)).to eq(nil)
    end
  end
end
