require "./lib/transaction"
require "bigdecimal"
require "Rspec"

RSpec.describe Transaction do

  it "exists" do
    transaction = Transaction.new
    expect(transaction).to be_instance_of(Transaction)
  end
end
