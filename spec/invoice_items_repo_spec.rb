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
      expect(invoice_item.count).to eq(15)
    end
  end

  describe '#find_all_by_invoice_id' do
    it 'can find all invoice items by the invoice id' do
      iir = InvoiceItemsRepository.new("./data/invoice_items.csv")
      invoice_item = iir.find_all_by_invoice_id("1")
      # binding.pry
      expect(invoice_item.count).to eq(8)
      invoice_item = iir.find_all_by_invoice_id("205")
      expect(invoice_item.count).to eq(3)
      invoice_item = iir.find_all_by_invoice_id("2r5t")
      expect(invoice_item).to eq([])
    end
  end
  #
  # describe '#create' do
  #   it 'can create a new instance of InvoiceItems class' do
  #     iir = InvoiceItemsRepository.new("./data/invoice_items.csv")
  #     johnny = iir.create("Johnny")
  #     expect(johnny.class).to be(Merchant)
  #     invoice_item = iir.repository.sort_by do |invoice_item|
  #                 invoice_item.id
  #               end.last
  #     expect(invoice_item.id < johnny.id).to be true
  #     expect(johnny.name).to eq("Johnny")
  #   end
  # end
  #
  # describe '#update' do
  #   it 'can change the Merchants name' do
  #     iir = InvoiceItemsRepository.new("./data/invoice_items.csv")
  #     invoice_item = iir.find_by_id("12334364")
  #     expect(invoice_item.name).to eq("ToThePoints")
  #     iir.update("12334364", {:name => "ToTheRounds"})
  #     # invoice_item = iir.find_by_id("12334364")
  #     expect(invoice_item.name).to eq("ToTheRounds")
  #   end
  # end
  #
  # describe '#delete' do
  #   it 'can remove a invoice_item from the repository' do
  #     iir = InvoiceItemsRepository.new("./data/invoice_items.csv")
  #     invoice_item = iir.find_by_name("MattsNerdShoppe")
  #     expect(iir.repository.include?(invoice_item)).to be true
  #     iir.delete(invoice_item.id)
  #     expect(iir.repository.include?(invoice_item)).to be false
  #   end
  # end

end
