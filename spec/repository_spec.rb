require_relative '../lib/repository'

RSpec.describe Repository do
  describe '#initialize' do
    it 'exist' do
      repository = Repository.new

      expect(repository).to be_a(Repository)
    end
  end
  
end