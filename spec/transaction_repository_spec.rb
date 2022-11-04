require './spec/spec_helper'
require './lib/transaction_repository'

RSpec.describe TransactionRepository do 
  describe 'iteration 3' do
    let (:t1) {Transaction.new({
                                :id => 1,
                                :invoice_id => 2179,
                                :credit_card_number => '4068631943231473',
                                :credit_card_expiration_date => '0217',
                                :result => 'success',
                                :created_at => Time.now,
                                :updated_at => Time.now
                              })}
    let (:t2) {Transaction.new({
                                :id => 2,
                                :invoice_id => 46,
                                :credit_card_number => '4068631943231473',
                                :credit_card_expiration_date => '0813',
                                :result => 'success',
                                :created_at => Time.now,
                                :updated_at => Time.now
                              })}
    let (:t3) {Transaction.new({
                                :id => 3,
                                :invoice_id => 750,
                                :credit_card_number => '4271805778010747',
                                :credit_card_expiration_date => '1220',
                                :result => 'success',
                                :created_at => Time.now,
                                :updated_at => Time.now
                              })}
    let (:t4) {Transaction.new({
                                :id => 4,
                                :invoice_id => 4126,
                                :credit_card_number => '4048033451067370',
                                :credit_card_expiration_date => '0313',
                                :result => 'failed',
                                :created_at => Time.now,
                                :updated_at => Time.now
                              })}
    let (:transactions) {[t1, t2, t3, t4]}
    let (:t_repo) {TransactionRepository.new(transactions)}
    
    describe '#initialize' do 
      it 'exists and has attributes' do 
        expect(t_repo).to be_a(TransactionRepository)
        expect(t_repo.transactions).to eq([t1, t2, t3, t4])
      end
    end
    
    describe '#find_by_id(id)' do
      it 'returns nil or an instance with a matching id' do
        expect(t_repo.find_by_id(1)).to eq(t1)
        expect(t_repo.find_by_id(5)).to eq(nil)
      end
    end
    
    describe '#find_all_by_credit_card_number(ccn)' do
      it 'returns [] or a list of matches' do
        expect(t_repo.find_all_by_credit_card_number('4068631943231473')).to eq([t1, t2])
        expect(t_repo.find_all_by_credit_card_number('4177816490204479')).to eq([])
      end
    end
    
    describe '#find_all_by_result(result)' do
      it 'returns [] or a list of matches' do
        expect(t_repo.find_all_by_result('success')).to eq([t1, t2, t3])
        expect(t_repo.find_all_by_result('failed')).to eq([t4])
        expect(t_repo.find_all_by_result('failure')).to eq([])
      end
    end
    
    describe '#create(attributes)' do
      it 'will create a new instance of Transaction' do
        expect(t_repo.transactions).to eq([t1, t2, t3, t4])
        
        t5 = t_repo.create({:invoice_id => '3715',
                            :credit_card_number => '4297222478855497',
                            :credit_card_expiration_date => '1215',
                            :result => 'success'
                          })
        expect(t_repo.transactions).to eq([t1, t2, t3, t4, t5])
      end
    end
    
    describe '#update(id, attribute)' do
      it 'updates specific Transaction attributes' do
        expect(t_repo.transactions[-1].credit_card_number).to eq('4048033451067370')
        expect(t_repo.transactions[-1].credit_card_expiration_date).to eq('0313')
        expect(t_repo.transactions[-1].result).to eq('failed')
        
        t_repo.update(4, {:credit_card_number => '4242424242424242', 
                          :credit_card_expiration_date => '1225',
                          :result => 'success'})
        
        expect(t_repo.transactions[-1].credit_card_number).to eq('4242424242424242')
        expect(t_repo.transactions[-1].credit_card_expiration_date).to eq('1225')
        expect(t_repo.transactions[-1].result).to eq('success')
        expect(t_repo.transactions[-1].updated_at).to be > (t_repo.transactions[-1].created_at)
      end
      
      it 'will do nothing if the id does not exist' do
        t_repo.update(7, {:credit_card_number => '4242424242424242', 
                          :credit_card_expiration_date => '1225',
                          :result => 'success'})
        expect(t_repo.find_by_id(7)).to eq(nil)
      end
      
      it 'will not update attributes not specified in the method' do
        t_repo.update(4, {:id => 7, 
                          :invoice_id => 1234,
                          :result => 'success'})
        expect(t_repo.transactions[-1].id).to eq(4)
        expect(t_repo.transactions[-1].invoice_id).to eq(4126)
        expect(t_repo.transactions[-1].result).to eq('success')
      end
    end
    
    describe '#delete(id)' do
      it 'deletes the transaction with the given id' do
        t_repo.delete(1)
        
        expect(t_repo.find_by_id(1)).to eq(nil)
      end
    end
  end
end