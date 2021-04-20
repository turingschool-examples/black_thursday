require './lib/merchant'

RSpec.describe Merchant do
  describe '#initialize' do
    it 'exists' do
      details = {
        id: 5,
        name: 'Turing School'
      }

      m = Merchant.new(details)
      expect(m).to be_a Merchant
    end

    it 'has an id' do
      details = {
        id: 5,
        name: 'Turing School'
      }

      m = Merchant.new(details)
      expect(m.id).to eq 5
    end

    it 'has a name' do
      details = {
        id: 5,
        name: 'Turing School'
      }

      m = Merchant.new(details)
      expect(m.name).to eq 'Turing School'
    end
  end

  describe '#update_name' do
    it 'updates the name attribute' do
      details = {
        id: 5,
        name: 'Turing School'
      }

      m = Merchant.new(details)
      new_name = 'Turing School of Software and Design'
      m.update_name(new_name)
      expect(m.name).to eq new_name
    end
  end
end
