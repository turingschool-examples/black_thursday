# frozen_string_literal: true

require_relative '../lib/customer'

RSpec.describe Customer do
  it 'has attributes' do
    customer = Customer.new({
                              id: 500,
                              first_name: 'Hailey',
                              last_name: 'Veum',
                              created_at: Time.parse('2012-03-27 14:56:08 UTC'),
                              updated_at: Time.parse('2012-03-27 14:56:08 UTC')
                            })

    expect(customer.id).to eq 500
    expect(customer.id.class).to eq Integer
    expect(customer.first_name).to eq 'Hailey'
    expect(customer.first_name.class).to eq String
    expect(customer.last_name).to eq 'Veum'
    expect(customer.last_name.class).to eq String
    expect(customer.created_at).to eq Time.parse('2012-03-27 14:56:08 UTC')
    expect(customer.created_at.class).to eq Time
    expect(customer.updated_at).to eq Time.parse('2012-03-27 14:56:08 UTC')
    expect(customer.updated_at.class).to eq Time
  end
end
