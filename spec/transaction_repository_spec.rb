require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'

RSpec.describe TransactionRepository do
  let(:transaction_repository) { TransactionRepository.new }

  let(:t_1) { Transaction.new({ id: 6,
                                invoice_id: 8,
                                credit_card_number: '4242424242424242',
                                credit_card_expiration_date: '0220',
                                result: 'success',
                                created_at: Time.now,
                                updated_at: Time.now
                              }) }
  let(:t_2) { Transaction.new({ id: 1, 
                              invoice_id: 2,
                              credit_card_number: '4242424242424243',
                              credit_card_expiration_date: '0221',
                              result: 'failed',
                              created_at: Time.now,
                              updated_at: Time.now
                            }) }  

  describe '#initialize' do
    it 'exist' do
      expect(transaction_repository).to be_a(TransactionRepository)
    end
  end          
  
  describe 'all' do
    it 'starts as an empty array' do
      expect(transaction_repository.all).to eq([])
    end
  end

  describe '#find_by_id' do
    it 'returns an instance of transaction with a matching id' do
      transaction_repository.add_to_repo(t_1)
      transaction_repository.add_to_repo(t_2)

      expect(transaction_repository.find_by_id(6)).to eq(t_1)
      expect(transaction_repository.find_by_id(1)).to eq(t_2)
      expect(transaction_repository.find_by_id(9)).to be_nil
    end
  end

  describe '#find_all_by_invoice_id' do
    it 'returns empty array or all invoices with matching invoice_id' do
      transaction_repository.add_to_repo(t_1)
      transaction_repository.add_to_repo(t_2)
    
      expect(transaction_repository.find_all_by_invoice_id(8)).to eq([t_1])
      expect(transaction_repository.find_all_by_invoice_id(2)).to eq([t_2])
      expect(transaction_repository.find_all_by_invoice_id(4)).to eq([])
    end
  end

  describe '#find_all_by_credit_card_number' do
    it 'returns empty array or all matches with matching credit card number' do
      transaction_repository.add_to_repo(t_1)
      transaction_repository.add_to_repo(t_2)

      expect(transaction_repository.find_all_by_credit_card_number("4242424242424242")).to eq([t_1])
      expect(transaction_repository.find_all_by_credit_card_number("4242424242424243")).to eq([t_2])
      expect(transaction_repository.find_all_by_credit_card_number(4)).to eq([])
    end
  end

  describe '#find_all_by_result' do
    it 'returns empty array or all with matching result' do
      transaction_repository.add_to_repo(t_1)
      transaction_repository.add_to_repo(t_2)

      expect(transaction_repository.find_all_by_result('success')).to eq([t_1])
      expect(transaction_repository.find_all_by_result('failed')).to eq([t_2])
      expect(transaction_repository.find_all_by_result('doesntexist')).to eq([])
    end
  end

  describe '#create' do
    it 'can create a new transaction' do
      expect(transaction_repository.all).to eq([])

      transaction_repository.create({ id: 7,
                                      invoice_id: 9,
                                      credit_card_number: '4242424242424244',
                                      credit_card_expiration_date: '0222',
                                      result: 'success',
                                      created_at: Time.now,
                                      updated_at: Time.now
                                    }) 

      expect(transaction_repository.all.first.id).to eq(1)

      transaction_repository.create({ id: 8,
                                      invoice_id: 9,
                                      credit_card_number: '4242424242424245',
                                      credit_card_expiration_date: '0223',
                                      result: 'failed',
                                      created_at: Time.now,
                                      updated_at: Time.now
                                    }) 


      expect(transaction_repository.all.last.id).to eq(2)
      expect(transaction_repository.all.size).to eq(2)
    end
  end

  describe '#update' do
    it 'can update credit card number, expiration date, and result' do
      transaction_repository.add_to_repo(t_1)
      transaction_repository.add_to_repo(t_2)

      expect(transaction_repository.all[0].credit_card_number).to eq('4242424242424242')
      expect(transaction_repository.all[0].credit_card_expiration_date).to eq('0220')
      expect(transaction_repository.all[0].result).to eq('success')

      transaction_repository.update( 0, {credit_card_number: "4242424242421111"})
      transaction_repository.update( 0, {credit_card_expiration_date: '0230'})
      transaction_repository.update( 0, {result: 'success'})
    end
  end

  describe '#delete' do
    it 'deletes the transaction with the corresponding id' do
      transaction_repository.add_to_repo(t_1)
      transaction_repository.add_to_repo(t_2)

      expect(transaction_repository.all.size).to eq(2)

      transaction_repository.delete(6)
      expect(transaction_repository.all.size).to eq(1)

      transaction_repository.delete(1)
      expect(transaction_repository.all.size).to eq(0)
    end
  end
end

                              