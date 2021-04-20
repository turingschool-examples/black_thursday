require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/repository'

RSpec.describe Repository do
  describe 'initialization' do
    csv_path = "./data/items.csv"
    repository = Repository.new(csv_path, Item)

    it 'exists' do
      expect(repository).to be_instance_of(Repository)
    end

    it 'parses csv items upon instantiation to an array of hashes' do
      expect(repository.parsed_csv_data).to be_instance_of(Array)
      expect(repository.parsed_csv_data[0]).to be_instance_of(Hash)
    end
  end

  describe '#create method' do
    csv_path = "./data/items.csv"
    repository = Repository.new(csv_path, Item)

    it 'create objects can create objects' do
      expect(repository.array_of_objects[0]).to be_instance_of(Item)
    end
  end

  describe '#all method' do
    csv_path = "./data/items.csv"
    repository = Repository.new(csv_path, Item)

    it 'returns array of all items' do
      allow(repository).to receive(:array_of_objects) do
        [1, 2, 3, 4]
      end

      expect(repository.all).to eq([1, 2, 3, 4])
    end
  end

  describe '#find_by_id' do
    csv_path = "./data/items.csv"
    repository = Repository.new(csv_path, Item)

    it 'find_by_id returns an instance by matching id' do
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
    repository = Repository.new(csv_path, Item)

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
