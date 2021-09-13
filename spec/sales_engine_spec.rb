require './lib/sales_engine'

RSpec.describe SalesEngine do
  context 'Iteration 0' do
    it 'exists' do
      se = SalesEngine.new
      expect(se).to be_an_instance_of(SalesEngine)
    end
  end
end 
