require './lib/transaction'

RSpec.describe Transaction do
  describe '#initialize' do
    t = Transaction.new(
      id:                           6,
      invoice_id:                   8,
      credit_card_number:           4242424242424242,
      credit_card_expiration_date:  0220,
      result:                       'success',
      created_at:                   Time.now.to_s,
      updated_at:                   Time.now.to_s,
      repository:                   'repository'
    )
    it 'exists' do
      expect(t).to be_an_instance_of(Transaction)
    end
  end

  describe 'instance variables' do
    t = Transaction.new(
      id:                           6,
      invoice_id:                   8,
      credit_card_number:           4242424242424242,
      credit_card_expiration_date:  0220,
      result:                       'success',
      created_at:                   Time.now.to_s,
      updated_at:                   Time.now.to_s,
      repository:                   'repository'
    )
    it 'has an id' do
      expect(t.id).to eq(6)
    end
    it 'has a invoice id' do
      expect(t.invoice_id).to eq(8)
    end
    it 'has a credit card number' do
      expect(t.credit_card_number).to eq(4242424242424242)
    end
    it 'has a credit card experation date' do
      expect(t.credit_card_expiration_date).to eq(0220)
    end
    it 'has a result' do
      expect(t.result).to eq(:success)
    end
    # it 'has a repository' do
    #   expect(i.repository).to eq('repository')
    # end
  end
  describe 'instances of time' do
    it 'has a time created' do
      allow(Time).to receive(:now) do
        '12:58'
      end
      t = Transaction.new(
        id:                           6,
        invoice_id:                   8,
        credit_card_number:           4242424242424242,
        credit_card_expiration_date:  0220,
        result:                       'success',
        created_at:                   Time.now.to_s,
        updated_at:                   Time.now.to_s,
        repository:                   'repository'
      )

      expect(t.created_at).to eq('12:58')
    end
    it 'has a time updated' do
      allow(Time).to receive(:now) do
        '12:58'
      end
      t = Transaction.new(
        id:                           6,
        invoice_id:                   8,
        credit_card_number:           4242424242424242,
        credit_card_expiration_date:  0220,
        result:                       'success',
        created_at:                   Time.now.to_s,
        updated_at:                   Time.now.to_s,
        repository:                   'repository'
      )
      expect(t.updated_at).to eq('12:58')
    end
  end
end
