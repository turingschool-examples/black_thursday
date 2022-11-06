require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'

RSpec.describe TransactionRepository do
  it 'exists' do
    tr = TransactionRepository.new

    expect(tr).to be_a(TransactionRepository)
  end
end
