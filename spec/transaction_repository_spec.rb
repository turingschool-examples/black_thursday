# frozen_string_literal: true

require './lib/transaction'
require './lib/transaction_repository'


describe TransactionRepository do
  describe '#initialize' do
    it 'exists' do
      

      expect(t_repo).is_a? TransactionRepository
    end
  end
end
