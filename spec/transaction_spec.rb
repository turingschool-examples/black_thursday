require 'bigdecimal'
require_relative 'spec_helper'

RSpec.describe Transaction do

  before(:each) do
    @paths = {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    }
    @se = SalesEngine.from_csv(@paths)
    @tr = @se.transactions
  end

  it 'exists' do
    t = Transaction.new({
    :id          => 1,
    :invoice_id => 2179,
    :credit_card_number  => "4068631943231473",
    :credit_card_expiration_date  => "0217",
    :result  => :success,
    :created_at  => Time.now,
    :updated_at  => Time.now
    }, @tr)

    expect(t).to be_a(Transaction)
  end

  it 'has attributes' do
    time_stub = '2021-05-30 11:30:51 -0500'
    allow(Time).to receive(:now).and_return(time_stub)

    t = Transaction.new({
      :id          => 1,
      :invoice_id => 2179,
      :credit_card_number  => "4068631943231473",
      :credit_card_expiration_date  => "0217",
      :result  => :success,
      :created_at  => Time.now,
      :updated_at  => Time.now
      }, @tr)

    expect(t.id).to eq(1)
    expect(t.invoice_id).to eq(2179)
    expect(t.credit_card_number).to eq("4068631943231473")
    expect(t.credit_card_expiration_date).to eq("0217")
    expect(t.result).to eq(:success)
    expect(t.created_at.to_s).to eq(Time.now)
    expect(t.updated_at.to_s).to eq(Time.now)
  end

  it 'stores its states in a hash' do
    time_stub = '2021-05-30 11:30:51.343158 -050'
    allow(Time).to receive(:now).and_return(time_stub)

    t = Transaction.new({
      :id          => 1,
      :invoice_id => 2179,
      :credit_card_number  => "4068631943231473",
      :credit_card_expiration_date  => "0217",
      :result  => :success,
      :created_at  => Time.now,
      :updated_at  => Time.now
      }, @tr)
      t_hash = t.to_hash

    expect(t_hash).to be_a(Hash)
    expect(t_hash.keys.length).to eq(7)
    expect(t_hash.values.length).to eq(7)
    expect(t_hash[:id]).to eq(t.id)
    expect(t_hash[:invoice_id]).to eq(t.invoice_id)
    expect(t_hash[:credit_card_number]).to eq(t.credit_card_number)
    expect(t_hash[:credit_card_expiration_date]).to eq(t.credit_card_expiration_date)
    expect(t_hash[:result]).to eq(t.result)
    expect(t_hash[:created_at]).to eq(t.created_at)
    expect(t_hash[:updated_at]).to eq(t.updated_at)
  end

end
