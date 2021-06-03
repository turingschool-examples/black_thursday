require_relative '../lib/transaction'

RSpec.describe Transaction do
  before(:each) do
    @data = {
            :id => 6,
            :invoice_id => 8,
            :credit_card_number => "4242424242424242",
            :credit_card_expiration_date => "0220",
            :result => "success",
            :created_at => Time.now.year,
            :updated_at => Time.now.year
          }
    @repo = double('transaction repo')
    @t = Transaction.new(@data, @repo)
  end

  it 'exists' do
    expect(@t).to be_a(Transaction)
  end

  it 'has attributes' do
    allow_any_instance_of(Time).to receive(:now).and_return(2021)

    expect(@t.id).to eq(6)
    expect(@t.invoice_id).to eq(8)
    expect(@t.credit_card_number).to eq(4242424242424242)
    expect(@t.credit_card_expiration_date).to eq("0220")
    expect(@t.result).to eq('success')
    expect(@t.created_at).to eq(2021)
  end

  
end
