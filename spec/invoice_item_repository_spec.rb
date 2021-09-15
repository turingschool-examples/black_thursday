require './lib/invoice_item'
require './lib/invoice_item_repository'

RSpec.describe 'invoice_item_repository' do
  describe '#initialize' do
    it 'is an instance of InvoiceItemRepository' do
      path = './data/invoice_items.csv'
      iir = InvoiceItemRepository.new(path)

      expect(iir).to be_an_instance_of InvoiceItemRepository
    end
  end

  describe 'all' do
    it 'returns an array of all invoice item instances' do
      path = './data/invoice_items.csv'
      iir = InvoiceItemRepository.new(path)

      expect(iir.all).to be_an Array
    end
  end

  describe 'find_by_id' do
    it 'returns an instance of InvoiceItem with matching id' do
      path = './data/invoice_items.csv'
      iir = InvoiceItemRepository.new(path)

      expect(iir.find_by_id("1")).to be_an_instance_of(InvoiceItem)
      expect(iir.find_by_id("1").id).to eq("1")
      expect(iir.find_by_id("1").quantity).to eq("5")
      expect(iir.find_by_id("21831")).to eq(nil)
    end
  end

  describe 'find all by item id' do
    it 'returns all instances of InvoiceItem with the same item id' do
      path = './data/invoice_items.csv'
      iir = InvoiceItemRepository.new(path)

      expect(iir.find_all_by_item_id('263454779')).to be_an_instance_of(InvoiceItem)
      #expect(iir.find_all_by_item_id('263454779')).to be_an(Array)
    end
  end

  describe 'find all by invoice id' do
    it 'returns all instances of InvoiceItem with the same invoice id' do
      path = './data/invoice_items.csv'
      iir = InvoiceItemRepository.new(path)

      expect(iir.find_all_by_invoice_id('1')).to be_an_instance_of(InvoiceItem)
      #expect(iir.find_all_by_invoice_id("1")).to be_an(Array)
    end
  end

  describe 'create' do
    it 'creates a new instance of InvoiceItem' do
      path = './data/invoice_items.csv'
      iir = InvoiceItemRepository.new(path)

      attributes = {
        :id          => 6,
        :item_id     => 7,
        :invoice_id  => 8,
        :quantity    => 1,
        :unit_price  => 1099,
        :created_at  => Time.now,
        :updated_at  => Time.now
      }

      expect(iir.create(attributes).last.quantity).to eq(1)
      expect(iir.create(attributes).last.invoice_id).to eq(8)
    end
  end

  describe 'update' do
    it 'updates the quantity of unit price InvoiceItem' do
      path = './data/invoice_items.csv'
      iir = InvoiceItemRepository.new(path)

      attributes = {
        :id          => 6,
        :item_id     => 7,
        :invoice_id  => 8,
        :quantity    => 1,
        :unit_price  => 1099,
        :created_at  => Time.now,
        :updated_at  => Time.now
      }

      iir.update('1', attributes)
      expect(iir.find_by_id('1').quantity).to eq('1')
      expect(iir.find_by_id('1').unit_price).to eq('1099')
    end
  end

  describe 'delete' do
    it 'deletes an instance of InvoiceItem' do
      path = './data/invoice_items.csv'
      iir = InvoiceItemRepository.new(path)
      iir.delete('1')
      expect(iir.find_by_id('1')).to eq(nil)
    end
  end
end
