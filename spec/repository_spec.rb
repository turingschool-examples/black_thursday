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