require "Rspec"
require_relative "../lib/transaction"

describe Transaction do
  before :each do
    @t = Transaction.new({
      :id          => '1',
      :created_at  => '2016-01-11 09:34:06 UTC',
      :updated_at  => '2017-06-04 21:35:10 UTC',
      :invoice_id => '520',
      :credit_card_number => '4242424242424242',
      :credit_card_expiration_date => "0220",
      :result => "success",
    })
  end
