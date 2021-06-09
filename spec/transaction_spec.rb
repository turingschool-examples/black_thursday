require 'SimpleCov'
SimpleCov.start

require_relative '../lib/transaction'

RSpec.describe Transaction do
  before(:each) do
    @t = Transaction.new({
                          :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => '4242424242424242',
                          :credit_card_expiration_date => '0223',
                          :result => 'success',
                          :created_at => '2021-06-11 09:34:06 UTC',
                          :updated_at => '2021-06-11 09:34:06 UTC'
                        })
  end

  it 'exists' do
    expect(@t).to be_an_instance_of(Transaction)
  end

  it 'has attributes' do
    expect(@t.id).to eq(6)
    expect(@t.invoice_id).to eq(8)
    expect(@t.credit_card_number).to eq('4242424242424242')
    expect(@t.credit_card_expiration_date).to eq('0223')
    expect(@t.result).to eq(:success)
    expect(@t.created_at).to eq(Time.parse('2021-06-11 09:34:06 UTC'))
    expect(@t.updated_at).to eq(Time.parse('2021-06-11 09:34:06 UTC'))
  end

  it 'can parse time or create time' do
    t = Transaction.new({
                          :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => '4242424242424242',
                          :credit_card_expiration_date => '0223',
                          :result => 'success',
                          :created_at => '',
                          :updated_at => nil
                        })

    expect(t.created_at).to be_a(Time)
    expect(t.updated_at).to be_a(Time)

    allow(@ii).to receive(:created_at).and_return(Time.parse('2021-06-11 02:34:56 UTC'))
    expect(@ii.created_at).to eq(Time.parse('2021-06-11 02:34:56 UTC'))
  end

  it 'can update attributes' do
    @t.update({
                :credit_card_number => '4242424242425353',
                :credit_card_expiration_date => '0623',
                :result => 'failed',
              })

    expect(@t.credit_card_number).to eq('4242424242425353')
    expect(@t.credit_card_expiration_date).to eq('0623')
    expect(@t.result).to eq(:failed)
    expect(@t.updated_at).to be_a(Time)
  end
end
