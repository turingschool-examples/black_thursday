require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/repository'

RSpec.describe Repository do
  describe 'initialization' do
    csv_path = "./data/items.csv"
    repository = Repository.new(csv_path)

    it 'exists' do
      expect(repository).to be_instance_of(Repository)
    end

    xit 'parses csv items upon instantiation' do
      expect(repository.parse_csv(csv_path)).to be_instance_of(Array)
    end
  end
end
