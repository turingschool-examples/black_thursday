require "CSV"
require "Rspec"
require_relative "../lib/transaction_repo"

describe TransactionRepo do
  before :each do
    @tr = TransactionRepo.new('./data/transactions.csv')
  end

  it 'is an instance of TransactionRepo' do
    expect(@tr).to be_a TransactionRepo
  end

  it "creates an array full of hashes from the csv" do
    expect(@tr.to_array).to be_a Array
    expect(@tr.to_array.empty?).to be false
  end

  it "#all" do
    expect(@tr.all).to be_a Array
    expect(@tr.all.empty?).to be false
    expect(@tr.all[0]).to be_a Transaction
    expect(@tr.all.length).to eq 4985
  end

  it "#find_by_id" do
    expect(@tr.find_by_id(1)).to be_a Transaction
    expect(@tr.find_by_id(1).credit_card_expiration_date).to eq("0217")
    expect(@tr.find_by_id(30000)).to eq nil
  end

  xit "#find_all_by_item_id" do
    expect(@tr.find_all_by_item_id(-1)).to eq []
    expect(@tr.find_all_by_item_id(263519844).length).to eq(164)
  end

  xit "#find_all_by_invoice_id" do
    expect(@tr.find_all_by_invoice_id(-1)).to eq([])
    expect(@tr.find_all_by_invoice_id(1).length).to eq(8)
  end

  xit "#find_highest_id" do
    expect(@tr.find_highest_id).to be_a Integer
    expect(@tr.find_highest_id).to be > 21829
  end

  xit "#create" do
    attributes = {
              id: '1',
         item_id: '263519844',
      invoice_id: '1',
        quantity: '5',
      unit_price: '13635',
      created_at: Time.now.utc,
      updated_at: Time.now.utc
    }

    @tr.create(attributes)

    expect(@tr.find_by_id(21831).quantity).to eq(5)
  end

  xit "#update" do
    info =  {
          id: '1',
     item_id: '263519844',
  invoice_id: '1',
    quantity: '5',
  unit_price: '13635',
  created_at: Time.now.utc,
  updated_at: Time.now.utc
            }

    @tr.create(info)
    attributes = {
         quantity: '4',
         unit_price: '10000'
       }
    @tr.update(21831, attributes)
    expect(@tr.find_by_id(21831).quantity).to eq('4')
    expect(@tr.find_by_id(21831).unit_price).to eq('10000')
  end

  xit "#delete" do
    info =  {
          id: '1',
     item_id: '263519844',
  invoice_id: '1',
    quantity: '5',
  unit_price: '13635',
  created_at: Time.now.utc,
  updated_at: Time.now.utc
            }
    @tr.create(info)


    expect(@tr.find_by_id(21831)).to be_a(Transaction)
    @tr.delete(21831)
    expect(@tr.find_by_id(21831)).to eq nil
  end

end
