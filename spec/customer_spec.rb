require_relative '../lib/customer'

RSpec.describe Customer do
  let(:customer_1) { Customer.new({
    id: 6,
    first_name: 'Joan',
    last_name: 'Clarke',
    created_at:  Time.now,
    updated_at:  Time.now }) }

  let(:customer_2) { Customer.new({
    :id => 2,
    :first_name => 'Michael',
    :last_name => 'Jackson',
    :created_at => Time.now,
    :updated_at => Time.now }) }

  let(:customer_3) { Customer.new({
    :id => 8,
    :first_name => 'Argo',
    :last_name => 'Angus',
    :created_at => Time.now,
    :updated_at => Time.now }) }

  describe '#initialize' do
    it 'exists' do
      expect(customer_1).to be_a(Customer)
      expect(customer_1.first_name).to eq('Joan')
      expect(customer_1.last_name).to eq('Clarke')
    end
  end
end