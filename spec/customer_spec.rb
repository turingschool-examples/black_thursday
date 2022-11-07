# frozen_string_literal: true

require_relative '../lib/customer'

RSpec.describe Customer do
  let(:customer_1) { Customer.new({ id:           6,
                                    first_name:   'Joan',
                                    last_name:    'Clarke',
                                    created_at:   Time.now,
                                    updated_at:   Time.now }) }

  let(:customer_2) { Customer.new({ id:         2,
                                    first_name: 'Michael',
                                    last_name:  'Jackson',
                                    created_at: Time.now,
                                    updated_at: Time.now }) }

  let(:customer_3) { Customer.new({ id:          8,
                                    first_name:  'Argo',
                                    last_name:   'Angus',
                                    created_at:  Time.now,
                                    updated_at:  Time.now }) }

  describe '#initialize' do
    it 'exists' do
      expect(customer_1).to be_a(Customer)
    end
  end

  describe '#id' do
    it 'returns appropriate id as integer' do
      expect(customer_1.id).to eq(6)
      expect(customer_2.id).to eq(2)
      expect(customer_3.id).to eq(8)
    end
  end

  describe '#first_name and #last_name' do
    it 'returns first and last name of customers' do
      expect(customer_1.first_name).to eq('Joan')
      expect(customer_1.last_name).to eq('Clarke')

      expect(customer_2.first_name).to eq('Michael')
      expect(customer_2.last_name).to eq('Jackson')

      expect(customer_3.first_name).to eq('Argo')
      expect(customer_3.last_name).to eq('Angus')
    end
  end

  describe '#created_at' do
    it 'returns a Time instance for the date the item was first created' do
      expect(customer_1.created_at).to be_a(Time)
      expect(customer_2.created_at).to be_a(Time)
      expect(customer_3.created_at).to be_a(Time)
    end
  end

  describe '#updated_at' do
    it 'returns a Time instance for the date the item was last modified' do
      expect(customer_1.updated_at).to be_a(Time)
      expect(customer_2.updated_at).to be_a(Time)
      expect(customer_3.updated_at).to be_a(Time)

      expect(customer_1.updated_at.round(2)).to eq(customer_1.created_at.round(2))
    end
  end
end
