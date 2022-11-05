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
end