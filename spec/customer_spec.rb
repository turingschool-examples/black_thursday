require 'rspec'
require_relative './spec_helper'

RSpec.describe Customer do
  describe 'instantiation' do
    before :each do
      @c = Customer.new({
      :id         => 6,
      :first_name => "Joan",
      :last_name  => "Clarke",
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s
      })
    end

    it 'exists' do
      expect(@c).to be_a(Customer)
    end

    it 'has attributes' do
      expect(@c.id).to eq(6)
      expect(@c.first_name).to eq("Joan")
      expect(@c.last_name).to eq("Clarke")
    end
  end

  # describe 'methods' do
  #   it 'updates invoice status' do
  #     se = SalesEngine.new({
  #        :customers => 'spec/fixtures/customers.csv',
  #     })
  #     cr = CustomerRepository.new('spec/fixtures/customers.csv', se)
  #     c = Customer.new({
  #       :id         => 6,
  #       :first_name => "Joan",
  #       :last_name  => "Clarke",
  #       :created_at => Time.now.to_s,
  #       :updated_at => Time.now.to_s
  #     })
  #     attributes = {
  #       :first_name => "Jeff",
  #       :last_name => "Jefferson"
  #     }

  #     c.update_customer(attributes)
  #     expect(c.id).to eq(6)
  #     expect(c.first_name).to eq("Jeff")
  #     expect(c.last_name).to eq("Jefferson")
  #   end
  # end
end