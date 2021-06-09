require 'SimpleCov'
SimpleCov.start

require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'

RSpec.describe TransactionRepository do
  before :each do
    @tr = TransactionRepository.new('./spec/fixture_files/transactions_fixture.csv')
  end

  it 'exists' do
    expect(@tr).to be_an_instance_of(TransactionRepository)
  end

  it 'can create transaction objects' do
    expect(@tr.all[0]).to be_an_instance_of(Transaction)
  end

  it 'can return a list of transaction items' do
    expect(@tr.all.length).to eq(5)
  end

  it 'can find a transaction item or nil by ID' do
    expect(@tr.find_by_id(1)).to eq(@tr.all[0])
    expect(@tr.find_by_id(2)).to eq(@tr.all[1])
    expect(@tr.find_by_id(6)).to eq(nil)
  end

  it 'can find a transaction item or empty array by ID' do
    expect(@tr.find_all_by_invoice_id(3)).to eq([@tr.all[2]])
    expect(@tr.find_all_by_invoice_id(4)).to eq([@tr.all[3]])
    expect(@tr.find_all_by_invoice_id(8)).to eq([])
  end

  it 'finds an transaction by credit card number' do
    expect(@tr.find_all_by_credit_card_number('4177816490204479')).to eq([@tr.all[1]])
    expect(@tr.find_all_by_credit_card_number('4048033451067370')).to eq([@tr.all[3]])
  end

  it 'can return tranaction items by result' do
    expect(@tr.find_all_by_result(:success)).to eq([@tr.all[0], @tr.all[1], @tr.all[2], @tr.all[3], @tr.all[4]])
    expect(@tr.find_all_by_result(:failed)).to eq([])
  end

  it 'creates a new transaction instance with attributes' do
    expected = @tr.create({
                             :invoice_id                   => '1',
                             :credit_card_number           => '1234631943231473',
                             :credit_card_expiration_date  => '0825',
                             :result                       => 'failed'
                          })

    expect(@tr.all.length).to eq(6)
    expect(expected.credit_card_number).to eq('1234631943231473')
    expect(expected.credit_card_expiration_date).to eq('0825')
    expect(expected.result).to eq(:failed)
  end

  it 'finds transactions by ID and update attributes' do
    data = {
              :invoice_id         => '1',
              :credit_card_number => '1234631943231473',
           }
    @tr.update(3, data)
    expected = @tr.find_by_id(3)

    expect(expected.credit_card_number).to eq('1234631943231473')
  end

  it 'finds and deletes transaction by ID' do
    @tr.delete(2)
    expect(@tr.all.length).to eq(4)
  end
end
