require 'simpleCOV'
require './lib/customer'

RSpec.describe Customer do

  describe 'initialize' do
    it 'exists' do
      c = Customer.new(
        id: 6,
        first_name: 'Joan',
        last_name: 'Clarke',
        created_at: Time.now,
        udated_at: Time.now
      )

      expect(c).to be_an_instance_of(Customer)
    end

    it 'has an id' do
      c = Customer.new(
        id: 6,
        first_name: 'Joan',
        last_name: 'Clarke',
        created_at: Time.now,
        udated_at: Time.now
      )

        expect(c.id).to eq(6)
    end

    it 'has a first name' do
      c = Customer.new(
        id: 6,
        first_name: 'Joan',
        last_name: 'Clarke',
        created_at: Time.now,
        udated_at: Time.now
      )

      expect(c.first_name).to eq('Joan')
    end

    it 'has a last name' do
      c = Customer.new(
        id: 6,
        first_name: 'Joan',
        last_name: 'Clarke',
        created_at: Time.now,
        udated_at: Time.now
      )

      expect(c.last_name).to eq('Clarke')
    end

    it 'has a time created at' do
      allow(Time).to receive(:now) do
        '12:58'
      c = Customer.new(
        id: 6,
        first_name: 'Joan',
        last_name: 'Clarke',
        created_at: Time.now,
        udated_at: Time.now
      )

      expect(c.created_at).to eq('12:58')
      end
    end

    it 'has a time upated at' do
      allow(Time).to receive(:now) do
        '12:58'
      c = Customer.new(
        id: 6,
        first_name: 'Joan',
        last_name: 'Clarke',
        created_at: Time.now,
        udated_at: Time.now
      )

      expect(c.updated_at).to eq('12:58')
      end
    end
  end

  describe '#update' do
    it 'updates name attributes' do
      c = Customer.new(
        id: 6,
        first_name: 'Joan',
        last_name: 'Clarke',
        created_at: Time.now,
        udated_at: Time.now
      )

      c.update(
        first_name: 'Joan2',
        last_name: 'Clarke2'
      )

      expect(c.first_name).to eq('Joan2')
      expect(c.last_name).to eq('Clarke2')
    end
  end
end
