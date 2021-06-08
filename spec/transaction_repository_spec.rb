require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'

RSpec.describe TransactionRepository do
  before(:each) do
    @repo = TransactionRepository.new( './spec/fixtures/mock_transactions.csv')
  end

  it 'exists' do
    expect(@repo).to be_a(TransactionRepository)
  end

  it 'can create transaction instances' do
    @repo.all.each do |transaction|
      expect(transaction).to be_a(Transaction)
    end
  end

  it 'can find transactions by id' do
    expect(@repo.find_by_id(2).invoice_id).to eq(46)
    expect(@repo.find_by_id(3).invoice_id).to eq(750)
    expect(@repo.find_by_id(99999)).to eq(nil)
  end

  it 'can find all transactions by invoice id' do
    expect(@repo.find_all_by_invoice_id(3477).length).to eq(2)
    expect(@repo.find_all_by_invoice_id(3477)[0].id).to eq(24)
    expect(@repo.find_all_by_invoice_id(9999999)).to eq([])
  end

  it 'can find transactions by credit card' do
    expect(@repo.find_all_by_credit_card_number('123456789').length).to eq(2)
    expect(@repo.find_all_by_credit_card_number('123456789')[0].id).to eq(1)
    expect(@repo.find_all_by_credit_card_number('9999999')).to eq([])
  end

  it 'can find all by transaction result' do
    expect(@repo.find_all_by_result('success').length).to eq(40)
    expect(@repo.find_all_by_result('failed').length).to eq(10)
    expect(@repo.find_all_by_result('maybe')).to eq([])
  end

  it 'can create a new transaction' do
    attributes = {:invoice_id => 789,
                :credit_card_number => "9876543",
                :credit_card_expiration_date => "0606",
                :result => "success"}
    @repo.create(attributes)

    expect(@repo.all.length).to eq(51)
    expect(@repo.all.last.id).to eq(51)
  end

  it 'can update old transactions' do
    attributes = {:invoice_id => 789,
                :credit_card_number => "1111111",
                :credit_card_expiration_date => "0707",
                :result => "success"}
    @repo.update(2, attributes)

    expect(@repo.all.length).to eq(50)
    expect(@repo.find_by_id(2).credit_card_number).to eq('1111111')
    expect(@repo.update(99999, attributes)).to eq(nil)
  end

  it "#update updates a transaction" do
      original_time = @repo.find_by_id(2).updated_at
      attributes = {
        result: :failed
      }
      @repo.update(2, attributes)
      expected = @repo.find_by_id(2)
      expect(expected.result).to eq :failed
      expect(expected.credit_card_expiration_date).to eq "0813"
  end

  it 'can delete a transaction' do
    @repo.delete(50)

    expect(@repo.all.length).to eq(49)
    expect(@repo.all.last.id).to eq(49)
  end

  it '.invoice_paid_in_full' do
    expect(@repo.invoice_paid_in_full(2179)).to eq(true)
    expect(@repo.invoice_paid_in_full(1752)).to eq(false)
    expect(@repo.invoice_paid_in_full(500000)).to eq(false)
  end
end
