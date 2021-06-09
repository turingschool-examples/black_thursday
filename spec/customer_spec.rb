require 'rspec'
require_relative './spec_helper'

RSpec.describe Customer do
  describe 'instantiation' do
    it 'exists' do
      c = Customer.new({
      :id         => 6,
      :first_name => "Joan",
      :last_name  => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
      })
      expect(c).to be_a(Customer)
    end
  end
end