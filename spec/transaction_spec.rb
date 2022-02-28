require './lib/transaction'

RSpec.describe Transaction do

  it 'exists' do
    trans = Transaction.new({
      id: 6,
      invoice_id: 8,
      credit_card_number: "4242424242424242",
      credit_card_expiration_date: "0220",
      result: "success",
      created_at: Time.now,
      updated_at: Time.now
      })

      expect(trans).to be_a (Transaction)
  end

  it 'has attributes' do
    trans = Transaction.new({
      id: 6,
      invoice_id: 8,
      credit_card_number: "4242424242424242",
      credit_card_expiration_date: "0220",
      result: "success",
      created_at: Time.now,
      updated_at: Time.now
      })

      expect(trans.id).to eq(6)
      expect(trans.invoice_id).to eq(8)
      expect(trans.credit_card_number).to eq("4242424242424242")
      expect(trans.credit_card_expiration_date).to eq("0220")
      expect(trans.result).to eq("success")
      expect(trans.created_at).to be_a(Time)
      expect(trans.updated_at).to be_a(Time)
  end
end
