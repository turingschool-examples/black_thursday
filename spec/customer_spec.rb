require './lib/customer'

describe Customer do
  describe '#initialize' do
    it 'exists' do
      details = {
        id: 6,
        first_name: 'Joan',
        last_name: 'Clarke',
        created_at: Time.now,
        updated_at: Time.now
      }

      customer = Customer.new(details)

      expect(customer).is_a? Customer
    end

    it 'has an id' do
      details = {
        id: 6,
        first_name: 'Joan',
        last_name: 'Clarke',
        created_at: Time.now,
        updated_at: Time.now
      }

      customer = Customer.new(details)

      expect(customer.id).to eq 6
      expect(customer.id).is_a? Integer
    end

    it 'has a first and last name' do
      details = {
        id: 6,
        first_name: 'Joan',
        last_name: 'Clarke',
        created_at: Time.now,
        updated_at: Time.now
      }

      customer = Customer.new(details)

      expect(customer.first_name).to eq 'Joan'
      expect(customer.last_name).to eq 'Clarke'
    end

    it 'returns time instances' do
      details = {
        id: 6,
        first_name: 'Joan',
        last_name: 'Clarke',
        created_at: Time.now,
        updated_at: Time.now
      }

      customer = Customer.new(details)

      expect(customer.created_at).is_a? Time
      expect(customer.updated_at).is_a? Time
    end
  end
end
