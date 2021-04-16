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

    it 'parses csv items upon instantiation' do
      expect(repository.parsed_csv_data).to be_instance_of(Array)
    end
  end

  describe 'all method' do
    csv_path = "./data/items.csv"
    repository = Repository.new(csv_path)


    xit 'returns array of all items' do
      allow(repository).to receive(:array_of_objects) do
        [1, 2, 3, 4]
      end

      expect(repository.all.count).to eq([1, 2, 3, 4])
    end
  end
end

##ADDITIONAL PARSED CSV TESTS##
  # xit 'makes a hash' do
  #   expect(sales_engine.merchants).to eq("./data/merchants.csv")
  # end
  #
  # xit 'parse csv merchants' do
  #   expect(SalesEngine.parse_csv("./data/merchants.csv")).to be_instance_of(Array)
  # end
  #
  # # it 'parse csv items' do
  # #   expect(SalesEngine.parse_csv("./data/items.csv")).to be_instance_of(Array)
  # # end
  #
  # it 'creates hashes' do
  #   expect(SalesEngine.parse_csv("./data/merchants.csv")[0]).to be_instance_of(Hash)
  # end
