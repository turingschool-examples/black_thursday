require 'RSpec'
require 'CSV'
require 'invoice_item_repository'
require 'item_repo'

RSpec.describe InvoiceItemRepository do
  describe 'instantiation' do
    it '::new' do
      invoice_item_repo = InvoiceItemRepository.new

      expect(invoice_item_repo).to be_an_instance_of(InvoiceItemRepository)
    end

    it 'has attributes' do
      invoice_item_repo = InvoiceItemRepository.new

      expect(invoice_item_repo.invoice_item).to eq([])
    end
  end
end
#   describe '#methods' do
#     it '#all' do
#       invoice_item_repo = InvoiceItemRepository.new
#
#       expect(invoice_item_repo.all).to be_an_instance_of(Array)
#     end
#   end
# end
