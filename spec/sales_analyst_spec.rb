require_relative 'spec_helper'

RSpec.describe 'SalesAnalyst' do
  before :each do
    @sales_engine = SalesEngine.from_csv({
      :items => "fixture/item_fixture.csv",
      :merchants => "fixture/merchant_fixture.csv"
      })
  end
  describe 'instantiation' do
    it 'exists' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst).to be_a(SalesAnalyst)

    end
  end
end
