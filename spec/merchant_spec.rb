require 'SimpleCov'
SimpleCov.start

require_relative '../lib/merchant'

RSpec.describe Merchant do
  before :each do
    @m = Merchant.new({
                         :id => 5,
                         :name => 'Turing School'
                      })
  end

  it 'exists' do
    expect(@m).to be_an_instance_of(Merchant)
  end

  it 'initializes with attributes' do
    expect(@m.id).to eq(5)
    expect(@m.name).to eq('Turing School')
  end

  it 'can update attributes' do
    @m.update({:name => 'Turing School of Witchcraft and Wizardry'})

    expect(@m.name).to eq('Turing School of Witchcraft and Wizardry')
  end

  it 'can create time' do
    allow(@m).to receive(:created_at).and_return(Time.parse('2021-06-11 02:34:56 UTC'))
    expect(@m.created_at).to eq(Time.parse('2021-06-11 02:34:56 UTC'))
  end
end
