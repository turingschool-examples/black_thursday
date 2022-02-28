require 'rspec'
require './lib/invoice_items_repository'
require 'pry'

describe InvoiceItemsRepository do
  describe '#initialize' do
    it 'exists' do
      iir = InvoiceItemsRepository.new("./data/invoice_items.csv")
      expect(iir).to be_an_instance_of(InvoiceItemsRepository)
    end
  end

  describe '#all' do
    it 'lists all invoice items' do
      iir = InvoiceItemsRepository.new("./data/invoice_items.csv")
      expect(iir.all).to eq(iir.repository)
    end
  end

  describe '#find_by_id' do
    it 'can find an invoice item by the id' do
      iir = InvoiceItemsRepository.new("./data/invoice_items.csv")
      invoice_item = iir.find_by_id("244")
      expect(invoice_item.id).to eq("244")
      expect(invoice_item.quantity).to eq("2")
    end
  end

  describe '#find_all_by_item_id' do
    it 'can find all invoice items by the item id' do
      iir = InvoiceItemsRepository.new("./data/invoice_items.csv")
      invoice_item = iir.find_all_by_item_id("263520800")
      # require 'pry'; binding.pry
      expect(invoice_item.count).to eq(15)
    end
  end

  describe '#find_all_by_invoice_id' do
    it 'can find all invoice items by the invoice id' do
      iir = InvoiceItemsRepository.new("./data/invoice_items.csv")
      invoice_item = iir.find_all_by_invoice_id("1")
      expect(invoice_item.count).to eq(8)
      invoice_item = iir.find_all_by_invoice_id("205")
      expect(invoice_item.count).to eq(3)
      # invoice_item = iir.find_all_by_invoice_id("2r5t")
      # expect(invoice_item).to eq([])
    end
  end
  #
  describe '#create' do
    it 'can create a new instance of InvoiceItems class' do
      iir = InvoiceItemsRepository.new("./data/invoice_items.csv")
      harry = iir.create({item_id: 67983,
                          invoice_id: 305,
                          quantity: 3,
                          unit_price: 999,
                          created_at: Time.now,
                          updated_at: Time.now})
      expect(harry.class).to be(InvoiceItems)
      invoice_item = iir.repository.sort_by do |invoice_item|
                  invoice_item.id
                end.last
      expect(invoice_item.id.to_i < harry.id.to_i).to be true
      expect(harry.quantity).to eq(3)
    end
  end

  describe '#update' do
    it 'can change the InvoiceItems quantity, unit price and updated_at' do
      iir = InvoiceItemsRepository.new("./data/invoice_items.csv")
      invoice_item = iir.find_by_id("1008")
      expect(invoice_item.quantity).to eq("5")
      expect(invoice_item.unit_price).to eq("97806")
      iir.update("1008", {:quantity => 10,
                          :unit_price => 99978})
      invoice_item = iir.find_by_id("1008")
      expect(invoice_item.quantity).to eq(10)
      expect(invoice_item.unit_price).to eq(99978)
    end
  end

  describe '#delete' do
    it 'can remove a invoice_item from the repository' do
      iir = InvoiceItemsRepository.new("./data/invoice_items.csv")
      invoice_item = iir.find_by_id("5")
      expect(iir.repository.include?(invoice_item)).to be true
      iir.delete(invoice_item.id)
      expect(iir.repository.include?(invoice_item)).to be false
    end
  end

end
