require_relative './spec_helper'

RSpec.describe Invoice do
  describe 'instantiation' do
    before :each do
      i = Invoice.new({
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => Time.now,
        :updated_at  => Time.now,
      })
    end
  end
end