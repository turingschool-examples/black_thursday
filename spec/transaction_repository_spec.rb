require 'bigdecimal'
require_relative 'spec_helper'

RSpec.describe TransactionRepository do

  before(:each) do
    @paths = {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    }
    @se = SalesEngine.from_csv(@paths)
  end

  it "exists" do
    tr = @se.transactions

    expect(tr).to be_a(TransactionRepository)
  end

  it "calls and reads correct file path" do
    tr = @se.transactions
    ir_csv_data = tr.all

    expect(ir_csv_data.class).to eq(Array)
    expect(ir_csv_data.length).to eq(4985)

    data_validation = ir_csv_data.all? do |line|
      line.class == Transaction
    end

    expect(data_validation).to be(true)
  end

  it 'can find by id' do
    tr = @se.transactions
    id = 2
    result = tr.find_by_id(id)

    expect(result.id).to eq(id)
    expect(result.class).to eq(Transaction)
  end

  it 'can find all by invoice id' do
    tr = @se.transactions
    invoice_id = 2179
    result = tr.find_all_by_invoice_id(invoice_id)

    expect(result.length).to eq(2)
    expect(result.first.class).to eq(Transaction)
  end

  it 'can find all by credit_card_number' do
    tr = @se.transactions
    credit_card_number = "4848466917766329"
    result = tr.find_all_by_credit_card_number(credit_card_number)

    expect(result.length).to eq(1)
    expect(result.first.class).to eq(Transaction)
  end

  it 'can find all by result' do
    tr = @se.transactions
    result = :success
    expected = tr.find_all_by_result(result)

    expect(expected.length).to eq(4158)
    result = :failed
    expected = tr.find_all_by_result(result)

    expect(expected.length).to eq(827)
  end


  it 'can create new instance with attributes' do
    tr = @se.transactions
    attributes= {
          :id => create_new_id,
          :invoice_id => 8,
          :credit_card_number => "4242424242424242",
          :credit_card_expiration_date => "0220",
          :result => "success",
          :created_at => Time.now,
          :updated_at => Time.now
        }

    tr.create(attributes)
    result = tr.find_by_id(4986)

    expect(result.invoice_id).to eq(8)
  end

  it 'can update an existing Transaction instance' do
    tr = @se.transactions
    original_time = tr.find_by_id(4985).updated_at
    time_stub = '2021-05-30 11:30:51.343158 -050'
    allow(Time).to receive(:now).and_return(time_stub)
    attributes = {
          :id => create_new_id,
          :invoice_id => 3791,
          :credit_card_number => "4772428113593836",
          :credit_card_expiration_date => "0913",
          :result => "failed",
          :created_at => Time.now,
          :updated_at => Time.now
      }

      tr.update(4985, attributes)
      expected = tr.find_by_id(4985)

      expect(expected.result).to eq(:failed)
      expect(Time.parse(expected.updated_at)).to be > original_time
      expected = tr.find_by_id(21831)

      expect(expected).to eq nil
    end

  it 'can delete an existing Transaction instance' do
    tr = @se.transactions

    old_length = tr.all.length
    result = tr.delete(tr.all[0].id)
    new_length = tr.all.length

    expect(old_length - new_length).to eq(1)
  end
end
