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

    it 'returns array of all items' do
      allow(repository).to receive(:array_of_objects) do
        [1, 2, 3, 4]
      end

      expect(repository.all).to eq([1, 2, 3, 4])
    end
  end

  describe '#find_by_id' do
    csv_path = "./data/items.csv"
    repository = Repository.new(csv_path)

    it 'find_by_id returns an instance by matching id' do
      # mock = double('Item')
      # allow(mock).to receive(:new) do
      #
      # end
      # id = 263538760
      # expect(repository.find_by_id(id).id).to eq(id)
      # expect(repository.find_by_id(id).name).to eq("Puppy blankie")
      merchant1 = Merchant.new({id: 1234, name: "Repository class"})
      merchant2 = Merchant.new({id: 5678, name: "Test data"})
      allow(repository).to receive(:array_of_objects) do
        [merchant1, merchant2]
      end

      expect(repository.find_by_id(1234)).to eq(merchant1)
      expect(repository.find_by_id(1234).name).to eq("Repository class")
      expect(repository.find_by_id(5678)).to eq(merchant2)
    end

    it 'find_by_id returns a nil if no id match' do
      merchant1 = Merchant.new({id: 1234, name: "Repository class"})
      merchant2 = Merchant.new({id: 5678, name: "Test data"})
      allow(repository).to receive(:array_of_objects) do
        [merchant1, merchant2]
      end

      expect(repository.find_by_id(2345)).to eq(nil)
    end
  end

  describe `#delete` do
    csv_path = "./data/items.csv"
    repository = Repository.new(csv_path)

    it 'can delete item' do
      merchant1 = Merchant.new({id: 1234, name: "Repository class"})
      merchant2 = Merchant.new({id: 5678, name: "Test data"})

      allow(repository).to receive(:array_of_objects) do
        [merchant1, merchant2]
      end

      expect(repository.delete(1234)).to eq(merchant1)
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
