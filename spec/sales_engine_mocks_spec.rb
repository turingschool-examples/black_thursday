require './spec/sales_engine_mocks'

RSpec.describe SalesEngineMocks do
  describe '#sales_engine' do
    it 'returns a built sales engine' do
      sales_engine = SalesEngineMocks.sales_engine(self)

      expect(sales_engine).not_to eq nil
    end
  end
end
