require_relative '../lib/customer_repository'

RSpec.describe CustomerRepository do
  describe '#initilize' do
    it 'exists and has attributes' do
      cr = CustomerRepository.new

      expect(cr).to be_a CustomerRepository
    end
  end
end