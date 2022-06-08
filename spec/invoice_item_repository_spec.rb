require './lib/invoice_item_repository'

RSpec.describe InvoiceItemRepository do
  before :each do
    @filepath = './data/invoice_items.csv'
    @collection = InvoiceItemRepository.new(@filepath)
    @attributes = {
      :item_id => 7,
      :invoice_id => 26359994,
      :quantity => 1,
      :unit_price => 1099,
      :created_at => Time.parse('1994-05-07 23:38:43 UTC'),
      :updated_at => Time.parse('2016-01-11 11:30:35 UTC')
    }
  end

  describe '#initialize' do
    it 'is an InvoiceRepository' do
      expect(@collection).to be_a InvoiceItemRepository
    end

    it 'can return an array of all known Invoice item instances' do
      expect(@collection.all).to be_a Array
      expect(@collection.all.count).to eq 21830
      expect(@collection.all.first).to be_a InvoiceItem
      expect(@collection.all.first.id).to eq 1
    end
  end

  describe '#find_by_id' do
    it 'returns nil if no invoice item has the searched id' do
      expect(@collection.find_by_id(2813308004)).to eq nil
    end

    it 'can return an invoice item with a matching id' do
      expect(@collection.find_by_id(1)).to be_a InvoiceItem
      expect(@collection.find_by_id(1).item_id).to eq 263519844

    end
  end

  describe '#find_all_by_item_id' do
    it 'returns an empty array if no invoice items have matching customer id' do
      expect(@collection.find_all_by_item_id(2813308004)).to eq []
    end

    it 'returns an array if invoices have matching item id' do
      expect(@collection.find_all_by_item_id(263519844).count).to eq 164
      expect(@collection.find_all_by_item_id(263539664).count).to eq 23
    end
  end

  describe '#find_all_by_invoice_id' do
    it 'returns an empty array if no invoice items have matching invoice id' do
      expect(@collection.find_all_by_invoice_id(2813308004)).to eq []
    end

    it 'returns an array if invoice items have matching invoice id' do
      expect(@collection.find_all_by_invoice_id(1).count).to eq 8
      expect(@collection.find_all_by_invoice_id(2).count).to eq 4
    end
  end

  describe '#create' do
    it 'can create a new Invoice item with provided attributes' do
      expect(@collection.find_by_id(498609087)).to eq nil
      @collection.create(@attributes)
      expect(@collection.find_by_id(21831)).to be_a InvoiceItem
      expect(@collection.find_by_id(21831).item_id).to eq 7
      expect(@collection.find_by_id(21831).invoice_id).to eq 26359994
      expect(@collection.find_by_id(21831).quantity).to eq 1
      expect(@collection.find_by_id(21831).unit_price).to eq 0.1099e2
      expect(@collection.find_by_id(21831).created_at).to eq Time.parse('1994-05-07 23:38:43 UTC')
      expect(@collection.find_by_id(21831).updated_at).to eq Time.parse('2016-01-11 11:30:35 UTC')
    end
  end

  describe '#update' do
    it 'can update the status of an invoice item' do
      expect(@collection.find_by_id(21830).quantity).to eq '4'
      expect(@collection.find_by_id(21830).unit_price).to eq 0.13635e3
      attributes = {quantity: 3, unit_price: 1199}
      @collection.update(21830, attributes)
      expect(@collection.find_by_id(21830).quantity).to eq 3
      expect(@collection.find_by_id(21830).unit_price).to eq 1199
      expect(@collection.find_by_id(21830).updated_at).not_to eq Time.parse('2016-01-06')
    end
  end

  describe '#delete' do
    it 'can delete an Invoice item based on id' do
      expect(@collection.find_by_id(21830).quantity).to eq '4'
      @collection.delete(21830)
      expect(@collection.find_by_id(21830)).to eq nil
    end
  end
end
