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
end
