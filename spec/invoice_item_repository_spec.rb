require './spec_helper'
require './lib/invoice_item'
require './lib/invoice_item_repository'

RSpec.describe InvoiceItemRepository do
  let (:ii_1) {InvoiceItem.new({
                :id => 6,
                :item_id => 7,
                :invoice_id => 8,
                :quantity => 1,
                :unit_price => BigDecimal(10.99, 4),
                :created_at => Time.now,
                :updated_at => Time.now
              })}
  let (:ii_2) {InvoiceItem.new({
                :id => 4,
                :item_id => 23,
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

end
