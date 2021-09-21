require 'pry'
require './lib/transaction'

RSpec.describe do
  it 'exists' do
    t = Transaction.new({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
  })
    expect(t).to be_an_instance_of(Transaction)
  end

  it "has attributes" do
    t = Transaction.new({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    expect(t.id).to eq(6)
    expect(t.invoice_id).to eq(8)
    expect(t.credit_card_number).to eq("4242424242424242")
    expect(t.credit_card_expiration_date).to eq("0220")
    expect(t.result).to eq("success")
    expect(t.created_at.round(2)).to eq(Time.now.round(2))
    expect(t.updated_at.round(2)).to eq(Time.now.round(2))
    end
  end
