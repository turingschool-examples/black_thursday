require './lib/customer'

RSpec.describe Customer do
  describe '#initialize' do
    it 'exists and has readable attributes' do
      time1 = Time.now
      time2 = Time.now
      data = {
                id:          6,
                first_name:  'Joan',
                last_name: 'Clarke',
                created_at:   time1,
                updated_at:   time2
      }
      customer = Customer.new(data)

      expect(customer).to be_a Customer
      expect(customer.id).to eq 6
      expect(customer.first_name).to eq 'Joan'
      expect(customer.last_name).to eq 'Clarke'
      expect(customer.created_at).to eq time1
      expect(customer.updated_at).to eq time2
    end
  end

  describe '#update' do
    it 'can update first or last name and log the time updated' do
      time1 = Time.now
      time2 = Time.now
      data = {
        id:               6,
        first_name:  'Joan',
        last_name: 'Clarke',
        created_at:   time1,
        updated_at:   time2
      }
      customer = Customer.new(data)
      customer.update({ first_name: 'Timbo', last_name: 'Tombo'})

      expect(customer.updated_at).to be_within(0.5).of Time.now
      expect(customer.first_name).to eq 'Timbo'
      expect(customer.last_name).to eq 'Tombo'
    end
  end
end
