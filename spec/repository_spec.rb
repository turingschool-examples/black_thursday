require_relative '../lib/repository'

RSpec.describe Repository do
  let(:repository) { Repository.new }
  describe '#initialize' do
    it 'exist' do
      expect(repository).to be_a(Repository)
    end
  end

  describe '#add to repo' do
    it 'can add an instance to repo' do
      invoice_1 = double("Thing")
      invoice_2 = double("Thing2")

      repository.add_to_repo(invoice_1)
      repository.add_to_repo(invoice_2)

      expect(repository.all).to eq([invoice_1, invoice_2])
    end
  end

  describe '#find_by_id' do
    it 'returns an instance of merchant with matching id' do
      merchant_1 = double({ id: 6, name: 'Walmart' })
      merchant_2 = double({ id: 7, name: 'Target' })
      repository.add_to_repo(merchant_1)
      repository.add_to_repo(merchant_2)

      expect(repository.find_by_id(6)).to eq(merchant_1)
      expect(repository.find_by_id(7)).to eq(merchant_2)
      expect(repository.find_by_id(1)).to eq(nil)
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'returns all instances with matching merchant id' do
      item_1 = double({
            :id          => 1,
            :name        => 'Pencil',
            :description => 'You can use it to write things',
            :unit_price  => '1099',
            :created_at  => Time.now,
            :updated_at  => Time.now,
            :merchant_id => 2})
      item_2 = double({
            :id          => 2,
            :name        => 'Pen',
            :description => 'You can use it to permanently write things',
            :unit_price  => '1299',
            :created_at  => Time.now,
            :updated_at  => Time.now,
            :merchant_id => 7})
      item_3 = double({
            :id          => 3,
            :name        => 'Stapler',
            :description => 'Attaches pieces of paper together',
            :unit_price  => '1999',
            :created_at  => Time.now,
            :updated_at  => Time.now,
            :merchant_id => 7})
      repository.add_to_repo(item_1)
      repository.add_to_repo(item_2)
      repository.add_to_repo(item_3)

      expect(repository.find_all_by_merchant_id(2)).to eq([item_1])
      expect(repository.find_all_by_merchant_id(7)).to eq([item_2, item_3])
      expect(repository.find_all_by_merchant_id(1)).to eq([])
    end
  end

  describe '#max_id' do
    it 'returns the number one higher than current highest ID number' do
      merchant_1 = double({ id: 6, name: 'Walmart' })
      repository.add_to_repo(merchant_1)

      expect(repository.max_id).to eq(7)

      merchant_2 = double({ id: 102348, name: 'Target' })
      repository.add_to_repo(merchant_2)

      expect(repository.max_id).to eq(102349)
    end

    it 'returns 1 if there are no instances in repo' do
      expect(repository.max_id).to eq(1)
    end
  end

  describe '#child_class_name' do
    it 'returns a string of what comes before the Repository in child class' do
      class ThingRepository < Repository
      end
      thing_repo = ThingRepository.new
      expect(thing_repo.child_class_name).to eq('Thing')
    end
  end

  describe '#delete' do
    it 'delete the merchant id with matching id' do
      merchant_1 = double({ id: 6, name: 'Walmart' })
      merchant_2 = double({ id: 7, name: 'Target' })
      repository.add_to_repo(merchant_1)
      repository.add_to_repo(merchant_2)

      repository.delete(6)

      expect(repository.all).to eq([merchant_2])

      repository.delete(1)

      expect(repository.all).to eq([merchant_2])
    end
  end
end
