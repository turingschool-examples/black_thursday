require 'RSpec'
require 'SimpleCov'
require_relative '../lib/invoice_item.rb'
require_relative '../lib/invoice_item_repository.rb'
require_relative '../lib/findable.rb'
require_relative '../lib/crudable.rb'
require_relative '../lib/sales_engine.rb'
require 'BigDecimal'
require 'Time'
SimpleCov.start

RSpec.describe InvoiceItemRepository do
  # declares variables to be used by following tests
  before :each do
    @invoice_item_1 = InvoiceItem.new({ id: 6, item_id: 7, invoice_id: 8, quantity: 1, unit_price: 10.99,
                                        created_at: "2022-02-25 17:49:56.871723", updated_at: "2022-02-26 00:51:07 UTC" })
    @invoice_item_2 = InvoiceItem.new({ id: 7, item_id: 8, invoice_id: 9, quantity: 2, unit_price: 9.99,
                                        created_at: "2022-02-25 17:49:56.871723", updated_at: "2022-02-26 00:51:07 UTC" })
    @invoice_item_3 = InvoiceItem.new({ id: 8, item_id: 9, invoice_id: 10, quantity: 3, unit_price: 3.99,
                                        created_at: "2022-02-25 17:49:56.871723", updated_at: "2022-02-26 00:51:07 UTC" })
    @iir = InvoiceItemRepository.new([@invoice_item_1, @invoice_item_2, @invoice_item_3])
  end

  it 'exists' do
    expect(@iir).to be_a(InvoiceItemRepository)
  end

  it 'has attributes' do
    expect(@iir.all).to be_a(Array)
  end

  it 'finds by invoice_item id' do
    expect(@iir.find_by_id(6)).to eq(@invoice_item_1)
    expect(@iir.find_by_id(7)).to eq(@invoice_item_2)
    expect(@iir.find_by_id(8)).to eq(@invoice_item_3)
  end

  it 'find all by item_id' do
    expect(@iir.find_all_by_item_id(7)).to eq([@invoice_item_1])
    expect(@iir.find_all_by_item_id(8)).to eq([@invoice_item_2])
    expect(@iir.find_all_by_item_id(9)).to eq([@invoice_item_3])
  end

  it 'find all by invoice_id' do
    expect(@iir.find_all_by_invoice_id(8)).to eq([@invoice_item_1])
    expect(@iir.find_all_by_invoice_id(9)).to eq([@invoice_item_2])
    expect(@iir.find_all_by_invoice_id(10)).to eq([@invoice_item_3])
  end

  it 'can create new invoice_items' do
    @iir.create({ id: 9, item_id: 10, invoice_id: 11, quantity: 4, unit_price: 3,
                  created_at: "2022-02-25 17:49:56.871723", updated_at: "2022-02-26 00:51:07 UTC" })
    expect(@iir.all.length).to eq(4)
    expect(@iir.all.last).to be_a(InvoiceItem)
  end

  it 'can update invoice_items' do
    invoice_item_1 = InvoiceItem.new({ id: 6, item_id: 7, invoice_id: 8, quantity: 1, unit_price: 10.99,
                                       created_at: "2022-02-25 17:49:56.871723", updated_at: "2022-02-26 00:51:07 UTC" })
    invoice_item_2 = InvoiceItem.new({ id: 7, item_id: 8, invoice_id: 9, quantity: 2, unit_price: 9.99,
                                       created_at: "2022-02-25 17:49:56.871723", updated_at: "2022-02-26 00:51:07 UTC" })
    invoice_item_3 = InvoiceItem.new({ id: 8, item_id: 9, invoice_id: 10, quantity: 3, unit_price: 3.99,
                                       created_at: "2022-02-25 17:49:56.871723", updated_at: "2022-02-26 00:51:07 UTC" })
    invoice_item_4 = InvoiceItem.new({ id: 9, item_id: 10, invoice_id: 11, quantity: 4, unit_price: 4.99,
                                       created_at: "2022-02-25 17:49:56.871723", updated_at: "2022-02-26 00:51:07 UTC" })
    iir = InvoiceRepository.new([invoice_item_1, invoice_item_2, invoice_item_3, invoice_item_4])

    expect(invoice_item_3.id).to eq(8)
    expect(invoice_item_3.quantity).to eq(3)
    expect(invoice_item_3.unit_price).to eq(3.99)
  end

  it 'can delete invoice_item instance by id' do
    @iir.delete(7)
    expect(@iir.all).to eq([@invoice_item_1, @invoice_item_3])
    @iir.delete(6)
    expect(@iir.all).to eq([@invoice_item_3])
    @iir.delete(8)
    expect(@iir.all).to eq([])
  end

  # it 'can sum invoice_items from a given invoice_id' do
  #   expect(@irr.sum_invoice_items(9)).to eq(0.1989e4)
  # end

  it 'initializes from SalesEngine#invoice_items()' do
    se = SalesEngine.from_csv({ :invoice_items => "./data/invoice_items.csv" })
    # se = SalesEngine.from_csv({ :items => "./data/items.csv", :merchants => "./data/merchants.csv",
    #                             :customers => "./data/customers.csv", :invoice_items => "./data/invoice_item.csv" })
    iir = se.invoice_items
    expect(@iir).to be_a(InvoiceItemRepository)
  end
end
