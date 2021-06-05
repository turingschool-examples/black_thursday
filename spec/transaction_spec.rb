require_relative '../lib/transaction'

RSpec.describe Transaction do
  before(:each) do
    @time = Time.now.utc.strftime("%m-%d-%Y %H:%M:%S %Z")
    @data = {
            :id => 6,
            :invoice_id => 8,
            :credit_card_number => "4242424242424242",
            :credit_card_expiration_date => "0220",
            :result => "success",
            :created_at => @time,
            :updated_at => @time
          }
    @repo = double('transaction repo')
    @t = Transaction.new(@data, @repo)
  end

  it 'exists' do
    expect(@t).to be_a(Transaction)
  end

  it 'has attributes' do

    expect(@t.id).to eq(6)
    expect(@t.invoice_id).to eq(8)
    expect(@t.credit_card_number).to eq('4242424242424242')
    expect(@t.credit_card_expiration_date).to eq("0220")
    expect(@t.result).to eq(:success)
    expect(@t.created_at).to eq(Time.parse(@time))
  end

  it 'can create a new transaction' do
    attributes = {:invoice_id => 123,
                  :credit_card_number => "10101010101010",
                  :credit_card_expiration_date => "0422",
                  :result => "failed",
                  }

    allow(@repo).to receive(:next_highest_id).and_return(7)

    expect(Transaction.create(attributes, @repo)).to be_a(Transaction)
  end

  it 'can update an old transaction' do
    attributes = {:credit_card_number => "10101010101010",
                  :credit_card_expiration_date => "0422",
                  :result => "failed",
                  }

    @t.update(attributes)
    expect(@t.credit_card_expiration_date).to eq('0422')
  end
end
