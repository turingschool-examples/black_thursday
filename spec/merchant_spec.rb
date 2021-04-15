require 'timecop'
require './lib/merchant'

RSpec.describe Merchant do
  it 'exists' do
    m = Merchant.new({ id: 5, name: 'Turing School' }, 'repository')

    expect(m).to be_instance_of(Merchant)
  end

  before do
    Timecop.freeze(Time.now)
  end

  after do
    Timecop.return
  end

  it 'has attributes' do
    m = Merchant.new({ id: 5, name: 'Turing School' }, 'repository')

    expect(m.id).to eq(5)
    expect(m.name).to eq( 'Turing School' )
    expect(m.created_at).to eq(Time.now)
    expect(m.updated_at).to eq(Time.now)
  end
end
