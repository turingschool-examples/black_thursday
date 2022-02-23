require 'rspec'
require 'csv'
require_relative './lib/sales_engine'
# require "./data/items.csv"
# require "./data/merchants.csv"

RSpec.describe SalesEngine do
  describe 'initialize' do
    it 'exists' do
      se = SalesEngine.from_csv({
                                  :items     => "./data/items.csv",
                                  :merchants => "./data/merchants.csv",
                                })
      expect(se).to be_a(SalesEngine)
    end
  end

end
