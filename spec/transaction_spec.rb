require 'csv'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction'
require_relative 'spec_helper'

#headers
#id,invoice_id,credit_card_number,credit_card_expiration_date,
#result,created_at,updated_at

RSpec.describe Transaction do
  before (:each) do
    @transaction= Transaction.new({id: 1,
      invoice_id: 2179,
      credit_card_number: "4068631943231473",
      credit_card_expiration_date: "0217",
      result: "success",
      created_at: "2012-02-26 20:56:56 UTC",
      updated_at: "2012-02-26 20:56:56 UTC" })
  end

    context 'InvoceItem' do
      it 'can read Item attributes' do
        expect(@transaction.id).to eq(1)
        expect(@transaction.invoice_id).to eq(2179)
        expect(@transaction.credit_card_number).to eq("4068631943231473")
        expect(@transaction.credit_card_expiration_date).to eq("0217")
        expect(@transaction.result).to eq("success")
        expect(@transaction.created_at).to eq(Time.parse("2012-02-26 20:56:56 UTC"))
        expect(@transaction.updated_at).to eq(Time.parse("2012-02-26 20:56:56 UTC"))
      end
    end
end
