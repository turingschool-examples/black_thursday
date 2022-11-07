require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'
require 'bigdecimal'

RSpec.describe InvoiceItemRepository do 
  let(:iir) { InvoiceItemRepository.new }

  let(:invoice_item_1) { InvoiceItem.new({
                                          :id => 6,
                                          :item_id => 7,
                                          :invoice_id => 8,
                                          :quantity => 1,
                                          :unit_price => BigDecimal("1099",4),
                                          :created_at => Time.now,
                                          :updated_at => Time.now
                                        })}
  let(:invoice_item_2) { InvoiceItem.new({
                                          :id => 1,
                                          :item_id => 2,
                                          :invoice_id => 8,
                                          :quantity => 2,
                                          :unit_price => BigDecimal("1299",4),
                                          :created_at => Time.now,
                                          :updated_at => Time.now
                                        })}
  let(:invoice_item_3) { InvoiceItem.new({
                                          :id => 9,
                                          :item_id => 2,
                                          :invoice_id => 11,
                                          :quantity => 3,
                                          :unit_price => BigDecimal("1599",4),
                                          :created_at => Time.now,
                                          :updated_at => Time.now
                                        })}

  describe '#initialize' do
    it 'exists' do
      expect(iir).to be_a(InvoiceItemRepository)
    end
  end
                                      
  describe 'all' do
    it 'starts as an empty array' do
      expect(iir.all).to eq([])
    end

    it 'can add invoice items to array' do 
      iir.add_to_repo(invoice_item_1)
      iir.add_to_repo(invoice_item_2)
      iir.add_to_repo(invoice_item_3)

      expect(iir.all).to eq([invoice_item_1, invoice_item_2, invoice_item_3])
    end
  end

  describe '#find_by_id' do
    it 'returns an instance of invoice item with a matching id' do
      iir.add_to_repo(invoice_item_1)
      iir.add_to_repo(invoice_item_2)
      iir.add_to_repo(invoice_item_3)

      expect(iir.find_by_id(6)).to eq(invoice_item_1)
      expect(iir.find_by_id(1)).to eq(invoice_item_2)
      expect(iir.find_by_id(55)).to be_nil
    end
  end

  describe '#find_all_by_item_id' do 
    it 'returns matches which have a matching item id' do 
      iir.add_to_repo(invoice_item_1)
      iir.add_to_repo(invoice_item_2)
      iir.add_to_repo(invoice_item_3)
      
      expect(iir.find_all_by_item_id(2)).to eq([invoice_item_2, invoice_item_3])
      expect(iir.find_all_by_item_id(76)).to eq([])
    end
  end

  describe '#find_all_by_invoice_id' do 
    it 'returns matches which have a matcing invoice id' do 
      iir.add_to_repo(invoice_item_1)
      iir.add_to_repo(invoice_item_2)
      iir.add_to_repo(invoice_item_3)

      expect(iir.find_all_by_invoice_id(8)).to eq([invoice_item_1, invoice_item_2])
      expect(iir.find_all_by_invoice_id(11)).to eq([invoice_item_3])
    end
  end
end