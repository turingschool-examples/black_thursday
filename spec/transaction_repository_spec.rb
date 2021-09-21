require './lib/transaction_repository'

RSpec.describe TransactionRepository do
  before(:each) do
    @engine = SalesEngine.from_csv({
                                       items: './data/items.csv',
                                       merchants: './data/merchants.csv',
                                       invoices: "./data/invoices.csv",
                                       invoice_items: './data/invoice_items.csv',
                                       transactions: './data/transactions.csv',
                                       customers: './data/customers.csv',
                                     })
  end

  it "exists" do
    expect(@engine.transactions).to be_an_instance_of(TransactionRepository)
  end

  it "all" do
    expect(@engine.transactions.all.count).to eq(4985)
  end

  it "find by id" do
    results = @engine.transactions.find_by_id(4986)
    expect(results).to eq(nil)
    results2 = @engine.transactions.find_by_id(1)
    expect(results2.credit_card_expiration_date).to eq("0217")
  end


  it "find_all_by_invoice_id" do
    results = @engine.transactions.find_all_by_invoice_id(2179)
    expect(results.first.id).to eq(1)
    result2 = @engine.transactions.find_all_by_invoice_id(9449495949959495954)
    expect(result2).to eq([])
  end

  it "find_all_by_credit_card_number" do
    result = @engine.transactions.find_all_by_credit_card_number('4055813232766404')
    expect(result.first.id).to eq(18)
  end

  it "find_all_by_result" do
    result = @engine.transactions.find_all_by_result(:success)
    expect(result.count).to eq(4158)
  end
  #change success string to success symbol

  it "highest_id" do
    expect(@engine.transactions.highest_id).to eq(4986)
  end

  it "create" do
    data = {
      invoice_id: 10_001,
      credit_card_number: 1111_1111_1111_1111,
      credit_card_expiration_date: 1001,
      result: "failed"
                        }
    @engine.transactions.create(data)
    expect(@engine.transactions.all.last.credit_card_expiration_date).to eq(1001)
    expect(@engine.transactions.all.last.id).to eq(4986)
  end

  it "update" do
    data = {
      credit_card_number: 1111_1111_1111_1111,
      credit_card_expiration_date: 1001,
      result: "failed"
                      }
    @engine.transactions.update(1, data)
    expect(@engine.transactions.all.first.credit_card_number).to eq('1111_1111_1111_1111')
    expect(@engine.transactions.all.first.credit_card_expiration_date).to eq(1001)
    expect(@engine.transactions.all.first.invoice_id).to eq(2179)
  end


  it "delete" do
    @engine.transactions.delete(1)
    expect(@engine.transactions.all.count).to eq(4984)
    expect(@engine.transactions.find_by_id(1)).to eq(nil)
  end

end
