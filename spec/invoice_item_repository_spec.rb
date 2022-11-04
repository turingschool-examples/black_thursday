require './spec_helper'
require './lib/invoice_item'
require './lib/invoice_item_repository'

RSpec.describe InvoiceItemRepository do
  let (:ii_1) {InvoiceItem.new({
                :id => 6,
                :item_id => 7,
                :invoice_id => 10,
                :quantity => 1,
                :unit_price => BigDecimal(10.99, 4),
                :created_at => Time.now,
                :updated_at => Time.now
              })}
  let (:ii_2) {InvoiceItem.new({
                :id => 4,
                :item_id => 2,
                :invoice_id => 10,
                :quantity => 2,
                :unit_price => BigDecimal(54.22, 4),
                :created_at => Time.now,
                :updated_at => Time.now
              })}
  let (:ii_3) {InvoiceItem.new({
                :id => 8,
                :item_id => 2,
                :invoice_id => 4,
                :quantity => 14,
                :unit_price => BigDecimal(24.42, 4),
                :created_at => Time.now,
                :updated_at => Time.now
              })}

  describe '#initialize' do
    it 'exists' do
      invoice_items = [ii_1, ii_2, ii_3]
      invoice_item_repository = InvoiceItemRepository.new(invoice_items)

      expect(invoice_item_repository).to be_a(InvoiceItemRepository)
    end
  end

  describe '#all' do
    it 'returns an array of all known invoice items' do
      invoice_items = [ii_1, ii_2, ii_3]
      invoice_item_repository = InvoiceItemRepository.new(invoice_items)

      expect(invoice_item_repository.all).to eq([ii_1, ii_2, ii_3])
    end
  end

  describe '#find_by_id' do
    it 'returns nil or an instance of invoice item with matching id' do
      invoice_items = [ii_1, ii_2, ii_3]
      invoice_item_repository = InvoiceItemRepository.new(invoice_items)

      expect(invoice_item_repository.find_by_id(8)).to eq(ii_3)
      expect(invoice_item_repository.find_by_id(10)).to eq(nil)
    end
  end

  describe '#find_all_by_item_id' do
    it 'find all invoice items with item id' do
      invoice_items = [ii_1, ii_2, ii_3]
      invoice_item_repository = InvoiceItemRepository.new(invoice_items)

      expect(invoice_item_repository.find_all_by_item_id(2)).to eq([ii_2, ii_3])
      expect(invoice_item_repository.find_all_by_item_id(7)).to eq([ii_1])
      expect(invoice_item_repository.find_all_by_item_id(14)).to eq([])
    end
  end

  describe '#find_all_by_invoice_id' do
    it 'find all invoice items with invoice id' do
      invoice_items = [ii_1, ii_2, ii_3]
      invoice_item_repository = InvoiceItemRepository.new(invoice_items)

      expect(invoice_item_repository.find_all_by_invoice_id(10)).to eq([ii_1, ii_2])
      expect(invoice_item_repository.find_all_by_invoice_id(4)).to eq([ii_3])
      expect(invoice_item_repository.find_all_by_invoice_id(22)).to eq([])
    end
  end

  describe "#create" do
    it 'will create a new invoice item' do
      invoice_items = [ii_1, ii_2, ii_3]
      invoice_item_repository = InvoiceItemRepository.new(invoice_items)

      expect(invoice_item_repository.all).to eq([ii_1, ii_2, ii_3])
      ii_4 = invoice_item_repository.create(:quantity => 24)
      expect(invoice_item_repository.all).to eq([ii_1, ii_2, ii_3, ii_4])
      expect(ii_4.id).to eq(9)
      expect(ii_4.quantity).to eq(24)
      expect(invoice_item_repository.find_by_id(9)).to eq(ii_4)
    end
  end

  describe '#all_ids' do
    it 'will return all ids' do
      invoice_items = [ii_1, ii_2, ii_3]
      invoice_items_repository = InvoiceItemRepository.new(invoice_items)

      expect(invoice_items_repository.all_ids).to eq([6, 4, 8])
    end
  end

  describe '#update' do
    it 'will update invoice item' do
      invoice_items = [ii_1, ii_2, ii_3]
      invoice_items_repository = InvoiceItemRepository.new(invoice_items)
      original_time = invoice_items_repository.find_by_id(8).update_time

      invoice_items_repository.update(8, {:id => 8, :quantity => 7})
      expect(invoice_items_repository.find_by_id(8).quantity).to eq(7)

      invoice_items_repository.update(8, {:id => 8, :unit_price => BigDecimal(68.22, 4)})
      expect(invoice_items_repository.find_by_id(8).unit_price).to eq(0.6822e2)

      expect(invoice_items_repository.find_by_id(8).updated_at).to be > original_time
    end
  end

  describe '#delete' do
    it 'will delete the invoice item with the matching id' do
      invoice_items = [ii_1, ii_2, ii_3]
      invoice_item_repository = InvoiceItemRepository.new(invoice_items)

      invoice_item_repository.delete(4)

      expect(invoice_item_repository.all).to eq([ii_1, ii_3])
      expect(invoice_item_repository.all.include?(ii_2)).to eq(false)
    end
  end
end
