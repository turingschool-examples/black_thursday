require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'

RSpec.describe TransactionRepository do
  it 'exists' do
    tr = TransactionRepository.new

    expect(tr).to be_a(TransactionRepository)
  end

  describe '#all' do
    it 'returns all transaction instances' do
      tr = TransactionRepository.new
      t = Transaction.new({
        :id => 6,
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => created = Time.now.to_s,
        :updated_at => updated = Time.now.to_s
        })

      expect(tr.all).to eq([])

      tr.all << t

      expect(tr.all).to eq([t])
    end
  end

  it 'finds the transaction instance by id' do
    tr = TransactionRepository.new
    t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => created = Time.now.to_s,
      :updated_at => updated = Time.now.to_s
      })

      tr.all << t

      expect(tr.find_by_id(6)).to eq(t)
      expect(tr.find_by_id(7)).to eq(nil)
  end
end
