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
  end
end
