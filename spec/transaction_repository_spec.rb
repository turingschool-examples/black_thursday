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

  describe '#find_all_by_invoice_id' do
    it ' returns [] or one or more matches w/ matching invoice id' do
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

        expect(tr.find_all_by_invoice_id(8)).to eq([t])
        expect(tr.find_all_by_invoice_id(34)).to eq([])
    end
  end

  describe '#find_all_by_credit_card_number' do
    it ' finds all transactions by matching id or returns empty []' do
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

      expect(tr.find_all_by_credit_card_number("4242424242424242")).to eq([t])
      expect(tr.find_all_by_credit_card_number("0000123")).to eq([])
    end
  end

  describe '#find_all_by_result' do
    it 'finds all the tranactions by a matching result or returns empty []' do
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

        expect(tr.find_all_by_result("success")).to eq([t])
        expect(tr.find_all_by_result("not success")).to eq([])
    end
  end

  describe '#create' do
    it 'creates a new transaction with provided attributes' do
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

        t2 = tr.create({
          :id => 10,
          :invoice_id => 9,
          :credit_card_number => "565656565642424242",
          :credit_card_expiration_date => "0217",
          :result => "fail",
          :created_at => created = Time.now.to_s,
          :updated_at => updated = Time.now.to_s
          })
          
        expect(t2).to be_a(Transaction)
        expect(t2.id).to eq(7)
        expect(t2.invoice_id).to eq(9)
        expect(t2.credit_card_number).to eq("565656565642424242")
        expect(t2.credit_card_expiration_date).to eq("0217")
        expect(t2.result).to eq("fail")
    end
  end
end
