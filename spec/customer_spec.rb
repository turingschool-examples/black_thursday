require 'rspec'
require './lib/customer.rb'

describe Customer do
  describe '#initialize' do
    it 'exists' do
      details = ({
        :id => 6,
        :first_name => 'Joan',
        :last_name => 'Clarke',
        :created_at => Time.now,
        :updated_at => Time.now
            })

      customer = Customer.new(details)

      expect(customer).is_a? Customer
    end

    it 'has an id' do
      details = ({
        :id => 6,
        :first_name => 'Joan',
        :last_name => 'Clarke',
        :created_at => Time.now,
        :updated_at => Time.now
            })

      customer = Customer.new(details)

      expect(customer.id).to eq 6
      expect(customer.id).is_a? Fixnum
    end
  end
end
