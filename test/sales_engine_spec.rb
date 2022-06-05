require './test/spec_helper'

RSpec.describe SalesEngine do
  before :each do
    @sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoice => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    })
  end

  it 'exists' do
    expect(@sales_engine).to be_instance_of SalesEngine
  end

  it 'can return an array of all items' do
    expect(@sales_engine.item_repository).to be_instance_of ItemRepository
  end

  it 'can return an array of all merchants' do
    expect(@sales_engine.merchant_repository).to be_instance_of MerchantRepository
    expect(@sales_engine.merchant_repository.all).to be_a Array
    expect(@sales_engine.merchant_repository.all.length).to eq(475)
  end

  it "can return an array of all items" do
    expect(@sales_engine.item_repository.all.class).to equal(Array)
    expect(@sales_engine.item_repository.all[0].class).to equal(Item)
    expect(@sales_engine.item_repository.all[0].name).to eq("510+ RealPush Icon Set")
  end

  it "can find items by id" do
    expect(@sales_engine.item_repository.find_by_id(263395237).name).to eq("510+ RealPush Icon Set")
    expect(@sales_engine.item_repository.find_by_id(123456)).to equal(nil)
  end

  it "can find items by name" do
    expect(@sales_engine.item_repository.find_by_name("510+ RealPush Icon Set").id).to eq(263395237)
    expect(@sales_engine.item_repository.find_by_name("510+ REALPUSH Icon Set").id).to eq(263395237)
    expect(@sales_engine.item_repository.find_by_name("MINNIE MUG")).to eq(nil)
  end

  it "can find items by description" do
    expect(@sales_engine.item_repository.find_all_with_description("tkjlds;afdkla")).to eq([])
    expect(@sales_engine.item_repository.find_all_with_description("dress up your cupcakes").count).to eq(3)
  end

  it "can find items by price" do
    expect(@sales_engine.item_repository.find_all_by_price(BigDecimal(10)).count).to eq(63)
    expect(@sales_engine.item_repository.find_all_by_price(BigDecimal(1000000)).count).to eq(0)
    expect(@sales_engine.item_repository.find_all_by_price(BigDecimal(10))[0].class).to eq(Item)
    expect(@sales_engine.item_repository.find_all_by_price(BigDecimal(10))[0].id).to eq(263405861)
  end

  it "can find items in a range" do
    expect(@sales_engine.item_repository.find_all_by_price_in_range(1000.00..1500.00).count).to eq(19)
    expect(@sales_engine.item_repository.find_all_by_price_in_range(1000.00..1500.00)[0].id).to eq(263416567)
  end

  it "can find items by merchant id" do
    expect(@sales_engine.item_repository.find_all_by_merchant_id(12334145).count).to eq(7)
    expect(@sales_engine.item_repository.find_all_by_merchant_id(12336020).count).to eq(2)
    expect(@sales_engine.item_repository.find_all_by_merchant_id(12334145)[1].id).to eq(263401045)
    expect(@sales_engine.item_repository.find_all_by_merchant_id(9874098)).to eq([])
  end

  it "can create a new item" do
    new_item = @sales_engine.item_repository.create({name: "Batmobile", description: "Black and shiny", unit_price: BigDecimal(10000, 5), created_at: Time.now, updated_at: Time.now, merchant_id: 88877766})
    expect(new_item.id).to eq(263567475)
    expect(@sales_engine.item_repository.all.last.name).to eq("Batmobile")
  end

  it "can update the item and items attributes" do
    new_item = @sales_engine.item_repository.create({name: "Batmobile", description: "Black and shiny", unit_price: BigDecimal(10000, 5), created_at: Time.now, updated_at: Time.now, merchant_id: 88877766})
    original_time = @sales_engine.item_repository.find_by_id(263567475).updated_at
    attributes = {unit_price: BigDecimal(379.99, 5)}
    @sales_engine.item_repository.update(263567475, attributes)
    expect(@sales_engine.item_repository.find_by_id(263567475).unit_price).to eq(BigDecimal(379.99, 5))
    expect(@sales_engine.item_repository.find_by_id(263567475).updated_at).to be > original_time
    attributes_2 = {name: "Batmobile Extreme"}
    @sales_engine.item_repository.update(263567475, attributes_2)
    expect(@sales_engine.item_repository.find_by_id(263567475).name).to eq("Batmobile Extreme")
    attributes_3 = {description: "Big and very loud"}
    @sales_engine.item_repository.update(263567475, attributes_3)
    expect(@sales_engine.item_repository.find_by_id(263567475).description).to eq("Big and very loud")
  end

  it "can delete items" do
    new_item = @sales_engine.item_repository.create({name: "Batmobile", description: "Black and shiny", unit_price: BigDecimal(10000, 5), created_at: Time.now, updated_at: Time.now, merchant_id: 88877766})
    @sales_engine.item_repository.delete(263567475)
    expect(@sales_engine.item_repository.find_by_id(263567475)).to eq(nil)
  end

  it 'can initialize a SalesAnalyst' do
      expect(@sales_engine.analyst).to be_instance_of(SalesAnalyst)
  end

  it "can create an InvoiceRepository" do
    expect(@sales_engine.invoice_repository).to be_instance_of(InvoiceRepository)
  end

  it 'returns an array of all known Invoice instances' do
    expect(@sales_engine.invoice_repository.all.count).to eq(4985)
  end

  it 'can returns nil or instance of Invoice' do
    expect(@sales_engine.invoice_repository.find_by_id(74587)).to equal(nil)
    expect(@sales_engine.invoice_repository.find_by_id(7)).to be_instance_of(Invoice)
  end

  it 'can return an empty [] or one or more with a matching customer id' do
    expect(@sales_engine.invoice_repository.find_all_by_customer_id(1000)).to eq([])
    expect(@sales_engine.invoice_repository.find_all_by_customer_id(300).length).to eq(10)
  end

  it 'returns either an empty [] or one or more matches with matching merchant id' do
    expect(@sales_engine.invoice_repository.find_all_by_merchant_id(1000)).to eq([])
    expect(@sales_engine.invoice_repository.find_all_by_merchant_id(12335080).length).to eq(7)
  end

  it 'returns an empty [] or one or more matches with having a matching status' do
    expect(@sales_engine.invoice_repository.find_all_by_status(:sold)).to eq([])
    expect(@sales_engine.invoice_repository.find_all_by_status(:shipped).length).to eq(2839)
    expect(@sales_engine.invoice_repository.find_all_by_status(:pending).length).to eq(1473)
  end

  it 'create a new invoice' do
    attributes = {
                  :customer_id => 7,
                  :merchant_id => 8,
                  :status      => "pending",
                  :created_at  => Time.now ,
                  :updated_at  => Time.now
                  }
    @sales_engine.invoice_repository.create(attributes)
    expect(@sales_engine.invoice_repository.find_by_id(4986)).to be_a(Invoice)
    expect(@sales_engine.invoice_repository.find_by_id(4986).merchant_id).to eq(8)
  end

  it 'can update invoice status' do
    attributes = {
                  :customer_id => 7,
                  :merchant_id => 8,
                  :status      => "pending",
                  :created_at  => Time.now ,
                  :updated_at  => Time.now
                  }
    @sales_engine.invoice_repository.create(attributes)
    invoice_updated_at = @sales_engine.invoice_repository.find_by_id(4986).updated_at
    expect(@sales_engine.invoice_repository.find_by_id(4986)).to be_a(Invoice)
    @sales_engine.invoice_repository.update(4986, {status: "success"})
    expect(@sales_engine.invoice_repository.find_by_id(4986).status).to eq(:success)

    expect(@sales_engine.invoice_repository.find_by_id(4986).updated_at).to be > invoice_updated_at
  end

  it 'is an InvoiceItemRepository' do
    expect(@sales_engine.invoice_items).to be_instance_of(InvoiceItemRepository)
  end

  it 'returns and array of all known InvoiceItem instances' do
    expect(@sales_engine.invoice_items.all.class).to eq(Array)
    expect(@sales_engine.invoice_items.all.count).to eq(21830)
    expect(@sales_engine.invoice_items.all[0].class).to eq(InvoiceItem)
  end

  it 'returns an instance of invoice item by id' do
    expect(@sales_engine.invoice_items.find_by_id(10).item_id).to eq(263523644)
    expect(@sales_engine.invoice_items.find_by_id(10).invoice_id).to eq(2)
    expect(@sales_engine.invoice_items.find_by_id(200000)).to eq(nil)
  end

  it 'returns an instance by invoice id' do
    expect(@sales_engine.invoice_items.find_all_by_invoice_id(100).length).to eq(3)
  end

  it 'creates a new invoice item instance' do
    attributes = {
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @sales_engine.invoice_items.create(attributes)
    expect(@sales_engine.invoice_items.find_by_id(21831).item_id).to eq(7)
  end

  it 'can update the quantity and unit price' do
    attributes = {
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @sales_engine.invoice_items.create(attributes)
    original_time = @sales_engine.invoice_items.find_by_id(21831).updated_at
    @sales_engine.invoice_items.update(21831, { quantity: 13})
    expect(@sales_engine.invoice_items.find_by_id(21831).quantity).to eq(13)
    expect(@sales_engine.invoice_items.find_by_id(21831).item_id).to eq 7
    expect(@sales_engine.invoice_items.find_by_id(21831).updated_at).to be > original_time

    @sales_engine.invoice_items.update(21831, { unit_price: BigDecimal(7.99, 4)})
    expect(@sales_engine.invoice_items.find_by_id(21831).unit_price).to eq(BigDecimal(7.99, 4))

    expect(@sales_engine.invoice_items.update(21831, { item_id: 21888})).to eq(nil)
  end

  it 'can delete an InvoiceItem' do
    attributes = {
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @sales_engine.invoice_items.create(attributes)
    @sales_engine.invoice_items.delete(21831)
    expect(@sales_engine.invoice_items.find_by_id(21831)).to eq(nil)
  end

  it 'is an instance of TransactionRepository' do
    expect(@sales_engine.transactions).to be_instance_of(TransactionRepository)
  end

  it 'has an array of Transactions' do
    expect(@sales_engine.transactions.all[0].class).to eq(Transaction)
    expect(@sales_engine.transactions.all.class).to eq(Array)
    expect(@sales_engine.transactions.all.count).to eq(4985)
  end

  it 'can find by id' do
    expect(@sales_engine.transactions.find_by_id(2).class).to eq(Transaction)
  end

  it 'can find all by Invoice id' do
    expect(@sales_engine.transactions.find_all_by_invoice_id(2179).length).to eq(2)
  end

  it 'can find all by credit card number' do
    expect(@sales_engine.transactions.find_all_by_credit_card_number("4848466917766329").length).to eq(1)
  end

  it 'can find all by result' do
    expect(@sales_engine.transactions.find_all_by_result(:success).length).to eq(4158)
    expect(@sales_engine.transactions.find_all_by_result(:success)[0].class).to eq(Transaction)
  end

  it 'can create a new Transaction' do
    attributes = {
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @sales_engine.transactions.create(attributes)
    expect(@sales_engine.transactions.find_by_id(4986).invoice_id).to eq(8)
  end

  it 'can create new attributes for a Transaction' do
    attributes = {
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @sales_engine.transactions.create(attributes)
    original_time = @sales_engine.transactions.find_by_id(4986).updated_at
    updates = {result: :failed}
    @sales_engine.transactions.update(4986, updates)
    expect(@sales_engine.transactions.find_by_id(4986).result).to eq(:failed)
    expect(@sales_engine.transactions.find_by_id(4986).credit_card_expiration_date).to eq("0220")
    expect(@sales_engine.transactions.find_by_id(4986).updated_at).to be > original_time

    update_fail = {invoice_id: 10}
    expect(@sales_engine.transactions.update(4986, update_fail)).to eq(nil)
  end

  it 'can delete an instance of a Transaction' do
    attributes = {
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @sales_engine.transactions.create(attributes)

    @sales_engine.transactions.delete(4986)
    expect(@sales_engine.transactions.find_by_id(4986)).to eq(nil)
  end
end
