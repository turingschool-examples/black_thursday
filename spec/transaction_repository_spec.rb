require 'pry'
require 'rspec'
require 'csv'
require 'date'
require './lib/transaction'
require './lib/transaction_repository'
require './lib/sales_module'

RSpec.describe TransactionRepository do
  before(:each) do
    @tr = TransactionRepository.new("./data/transactions.csv")
  end

  it 'exists' do
    expect(@tr).to be_a TransactionRepository
  end

  it 'has readable attributes' do
    expect(@tr.all.count).to eq(4985)
  end

  it 'can look up transactions by id' do
    # binding.pry
    test = @tr.find_by_id(1)
    expect(test).to be_an_instance_of(Transaction)
    expect(test.id).to be 1
  end

  it 'can find all the transactions by their invoice id' do
    id = 2179
    test = @tr.find_all_by_invoice_id(id)

    expect(test.length).to eq 2
    expect(test.first.invoice_id).to eq id
    expect(test.first.class).to eq Transaction

    id = 14560
    test = @tr.find_all_by_invoice_id(id)
    expect(test.empty?).to eq true
  end

  it 'can find all the transactions by the credit card number' do
    credit_card_number = "4848466917766329"
    expected = @tr.find_all_by_credit_card_number(credit_card_number)

    expect(expected.length).to eq 1
    expect(expected.first.class).to eq Transaction
    expect(expected.first.credit_card_number).to eq credit_card_number

    credit_card_number = "4848466917766328"
    expected = @tr.find_all_by_credit_card_number(credit_card_number)

    expect(expected.empty?).to eq true
  end

  it 'can find all the transactions by their result' do
    result = "success"
      expected = @tr.find_all_by_result(result)

      expect(expected.length).to eq 4158
      expect(expected.first.class).to eq Transaction
      expect(expected.first.result).to eq result

      result = "failed"
      expected = @tr.find_all_by_result(result)

      expect(expected.length).to eq 827
      expect(expected.first.class).to eq Transaction
      expect(expected.first.result).to eq result
  end

  it 'creates a new transaction object' do
    attributes = {
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
      }
      @tr.create(attributes)
      expected = @tr.find_by_id(4986)
      expect(expected.invoice_id).to eq 8
  end

  it 'updates a current transaction object' do
    attributes = {
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @tr.create(attributes)

    original_time = @tr.find_by_id(4986).updated_at
    attributes = {
      result: "failed"
    }
    @tr.update(4986, attributes)

    expected = @tr.find_by_id(4986)

    expect(expected.result).to eq "failed"
    expect(expected.credit_card_expiration_date).to eq "0220"
    expect(expected.updated_at).to be > original_time
  end

  it 'can delete transactions by id number' do
    attributes = {
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @tr.create(attributes)

    @tr.delete(4986)
    expected = @tr.find_by_id(4986)
    expect(expected).to eq nil
  end

end
