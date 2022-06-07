require './lib/invoice_item_repository'
require 'BigDecimal'
require 'CSV'


RSpec.describe InvoiceItemRepository do
  it 'exists' do
    invoice_items = './data/invoice_items.csv'
    ii_repo = InvoiceItemRepository.new(invoice_items)
    expect(ii_repo).to be_a(InvoiceItemRepository)
  end

  it 'returns an array of all known InvoiceItem instances' do
    invoice_items = './data/invoice_items.csv'
    ii_repo = InvoiceItemRepository.new(invoice_items)
    expect(ii_repo.all).to be_a(Array)
  end

    it 'return the amount of all known invoice_items instances' do
      invoice_items = './data/invoice_items.csv'
      ii_repo = InvoiceItemRepository.new(invoice_items)
      expect(ii_repo.all.count).to eq(21830)
    end

    it 'can find all by id' do
      invoice_items = './data/invoice_items.csv'
      ii_repo = InvoiceItemRepository.new(invoice_items)

      expect(ii_repo.find_by_id(1)).to be_an_instance_of(InvoiceItem)
      expect(ii_repo.find_by_id(999991)).to eq(nil)
    end

    it 'can find all by item_id' do
      invoice_items = './data/invoice_items.csv'
      ii_repo = InvoiceItemRepository.new(invoice_items)

      expect(ii_repo.find_all_by_item_id(263519844)).to be_an_instance_of(Array)
      expect(ii_repo.find_all_by_item_id(999991)).to eq([])
    end

    it 'can find all by invoice_id' do
    invoice_items = './data/invoice_items.csv'
    ii_repo = InvoiceItemRepository.new(invoice_items)

    expect(ii_repo.find_all_by_invoice_id(1)).to be_instance_of(Array)
    expect(ii_repo.find_all_by_invoice_id(999991)).to eq([])
    expect(ii_repo.find_all_by_invoice_id(1).size).to eq(8)
  end

  it 'can create attributes' do
    invoice_items = './data/invoice_items.csv'
    ii_repo = InvoiceItemRepository.new(invoice_items)
    new_item_attributes = {:item_id => "2635999123", :invoice_id => "4986",
    :unit_price => "99999",:quantity => "9"}

    new_item = (ii_repo.create(new_item_attributes))

    expect(new_item.id).to eq("21831")
    expect(new_item.item_id).to eq("2635999123")
    expect(new_item.invoice_id).to eq("4986")
    expect(new_item.unit_price).to eq("99999")
    expect(new_item.quantity).to eq("9")
    expect(new_item.created_at).to be_an_instance_of(Time)
    expect(ii_repo.find_by_id(21831)).to be_an_instance_of(InvoiceItem)
  end

  it 'can update Invoice items with attributes' do
    invoice_items = './data/invoice_items.csv'
    ii_repo = InvoiceItemRepository.new(invoice_items)

    expect(ii_repo.find_by_id(10).quantity).to eq("4")
    expect(ii_repo.find_by_id(10).unit_price).to eq("1859")

    new_test_attributes = {:quantity => "99", :unit_price => "2000", :updated_at => "1"}
    ii_repo.update(10, new_test_attributes)

    expect(ii_repo.find_by_id(10).quantity).to eq("99")
    expect(ii_repo.find_by_id(10).unit_price).to eq("2000")
    expect(ii_repo.find_by_id(10).updated_at).to be_an_instance_of(Time)

  end

    it 'can delete the InvoiceItem instance with the corresponding id' do
      invoice_items = './data/invoice_items.csv'
      ii_repo = InvoiceItemRepository.new(invoice_items)

      expect(ii_repo.find_by_id(10)).to be_a(InvoiceItem)
      item_repo.delete(10)
      expect(ii_repo.find_by_id(10)).to eq(nil)
    end

end
