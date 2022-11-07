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

  describe '#create' do 
    it 'can create a new invoice item' do
      expect(iir.all).to eq([])

      iir.create({ 
                  :item_id => 21,
                  :invoice_id => 22,
                  :quantity => 1,
                  :unit_price => BigDecimal("1999",4),
                  :created_at => Time.now,
                  :updated_at => Time.now
                })
      iir.create({ 
                  :item_id => 24,
                  :invoice_id => 25,
                  :quantity => 1,
                  :unit_price => BigDecimal("2099",4),
                  :created_at => Time.now,
                  :updated_at => Time.now
                })

      expect(iir.all[0].id).to eq(1)
      expect(iir.all[1].id).to eq(2)
      expect(iir.all.size).to eq(2)
    end
  end

  describe '#update' do 
    it 'can update an invoice item' do 
      iir.add_to_repo(invoice_item_1)
      iir.add_to_repo(invoice_item_2)
      iir.add_to_repo(invoice_item_3)

      expect(iir.all[0].quantity).to eq(1)
      expect(iir.all[1].quantity).to eq(2)
      expect(iir.all[2].quantity).to eq(3)

      iir.update( 6, {quantity: 55,
                      unit_price: BigDecimal("2299",4)
                    })
      iir.update( 1, {quantity: 56,
                      unit_price: BigDecimal("2399",4)
                    })
      iir.update( 9, {quantity: 57,
                      unit_price: BigDecimal("2499",4)
                    })

      expect(iir.all[0].quantity).to eq(55)
      expect(iir.all[0].unit_price).to eq(BigDecimal(2299,4))
      expect(iir.all[1].quantity).to eq(56)
      expect(iir.all[1].unit_price).to eq(BigDecimal(2399, 4))
      expect(iir.all[2].quantity).to eq(57)
      expect(iir.all[2].unit_price).to eq(BigDecimal(2499, 4))
    end
  end

  describe '#delete' do 
    it 'deletes the invoice item with the corresponding id' do
      iir.add_to_repo(invoice_item_1)
      iir.add_to_repo(invoice_item_2)
      iir.add_to_repo(invoice_item_3)

      expect(iir.all.size).to eq(3)

      iir.delete(6)
      expect(iir.all.size).to eq(2)

      iir.delete(1)
      expect(iir.all[0].item_id).to eq(2)
      expect(iir.all.size).to eq(1)
    end

    it 'cannot delete an id that does not exist' do
      iir.add_to_repo(invoice_item_1)
      iir.add_to_repo(invoice_item_2)
      iir.add_to_repo(invoice_item_3)

      expect(iir.all.size).to eq(3)

      iir.delete(12)

      expect(iir.all.size).to eq(3)
      expect(iir.all[0].item_id).to eq(7)
    end
  end
end
