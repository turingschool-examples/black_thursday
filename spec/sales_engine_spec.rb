require './lib/sales_engine'

RSpec.describe SalesEngine do
  context 'Iteration 0' do
    it 'exists' do
      se = SalesEngine.new
      expect(se).to be_an_instance_of(SalesEngine)
    end

    it 'can access items' do
      se = SalesEngine.new(paths[:items])
      expect(se).to be_an(Array)
    end

    it 'can access merchants' do
      se = SalesEngine.new(paths[:merchants])
      expect(se).to be_an(Array)
    end
  end
end
