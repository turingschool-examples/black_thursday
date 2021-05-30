require 'timecop'
require './lib/merchant'

RSpec.describe Merchant do
  describe '#initialize' do
    it 'exists' do
      m = Merchant.new(id: 5,
                       name: 'Turing School',
                       repository: 'repository',
                       created_at: Time.now,
                       updated_at: Time.now)

      expect(m).to be_instance_of(Merchant)
    end

    before do
      Timecop.freeze(Time.now)
    end

    after do
      Timecop.return
    end

    it 'has attributes' do
      m = Merchant.new(id: 5,
                       name: 'Turing School',
                       created_at: Time.now,
                       updated_at: Time.now,
                       repository: 'boo')

      expect(m.id).to eq(5)
      expect(m.name).to eq('Turing School')
      expect(m.created_at).to eq(Time.now)
      expect(m.updated_at).to eq(Time.now)
      expect(m.repository).to eq('boo')
    end
  end

  describe '#update' do
    it 'updates an instance' do
      m = Merchant.new(id: 5,
                       name: 'Turing School',
                       created_at: Time.now,
                       updated_at: Time.now,
                       repository: 'boo')

      m.update(name: 'TUS')

      expect(m.name).to eq('TUS')
      expect(m.id).to eq(5)
      expect(m.created_at).not_to eq(Time.now)
      expect(m.updated_at).not_to eq(Time.now)
      expect(m.repository).to eq('boo')
    end
  end

  describe '#writers' do
    it 'can write to the variables' do
      m = Merchant.new(id: 5,
                       name: 'Turing School',
                       repository: 'repository',
                       created_at: Time.now,
                       updated_at: Time.now)

      m.name = 'bob'
      m.updated_at = 'bob'

      expect(m.name).to eq('bob')
      expect(m.updated_at).to eq('bob')
    end
  end
end
