require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'

RSpec.describe ItemRepository do
  describe 'initialization' do
    repo = ItemRepository.new

    it 'exists' do
      expect(repo).to be_instance_of(ItemRepository)
    end
  end
end
