require './lib/invoice_repository'
require './lib/invoice'


RSpec.describe InvoiceRepository do
  let!(:invoice_repository) {Invoice.new({})}
end

it 'is a invoice repository class' do
  expect(invoice_repository).to be_a(InvoiceRepository)
end

it 'returns an array of all known invoices' do
  expect(invoice_repository.all).to eq()
end

it 'returns an instance of an invoice with matching id' do
  expect(invoice_repository.find_by_id()).to eq()
end

it 'returns nil if id is not within' do
  expect(invoice_repository.find_by_id()).to eq(nil)
  expect(invoice_repository.find_by_id()).to eq(nil)
end

it 'can find all customers with matching id in an array' do
  expect(invoice_repository.find_all_by_customer_id()).to eq([])
end

it 'returns nil if not valid customer id' do
  expect(invoice_repository.find_all_by_customer_id()).to eq(nil)
  expect(invoice_repository.find_all_by_customer_id()).to eq(nil)
end

it 'can find all merchants with matching id in an array' do
  expect(invoice_repository.find_all_by_merchant_id()).to eq([])
end

it 'returns nil if not a valid merchant id' do
  expect(invoice_repository.find_all_by_merchant_id()).to eq(nil)
  expect(invoice_repository.find_all_by_merchant_id()).to eq(nil)
end

it 'can return all that match a status' do
  expect(invoice_repository.find_all_by_status()).to eq([])
end

it 'returns nil if not a valid status' do
  expect(invoice_repository.find_all_by_status()).to eq(nil)
  expect(invoice_repository.find_all_by_status()).to eq(nil)
end

it 'can create a new invoice instance with attributes' do
  expect(invoice_repository.create()).to eq()
end

it 'gives the new invoice instance the highest id + 1' do
  expect(invoice_repository.all.last.id).to eq()

  invoice_repository.create()

  expect(invoice_repository.all.last.id).to eq()
end

it 'can update a merchant (by id) with new attributes' do
#will also change the invoices updated_at_attribute to current time
  expect(invoice_repository.find_by_id().name).to eq()

  invoice_repository.update(,)

  expect(invoice_repository.find_by_id().name).to eq()
end

it 'can delete an invoice instance by supplied id' do
  expect(invoice_repository.all.length).to eq()
  expect(invoice_repository.all).to eq()

  invoice_repository.delete()

  expect(invoice_repository.all.length).to eq()
  expect(invoice_repository.all).to eq()
end
# all - returns an array of all known Invoice instances
# find_by_id - returns either nil or an instance of Invoice with a matching ID
# find_all_by_customer_id - returns either [] or one or more matches which have a matching customer ID
# find_all_by_merchant_id - returns either [] or one or more matches which have a matching merchant ID
# find_all_by_status - returns either [] or one or more matches which have a matching status
# create(attributes) - create a new Invoice instance with the provided attributes. The new Invoice’s id should be the current highest Invoice id plus 1.
# update(id, attribute) - update the Invoice instance with the corresponding id with the provided attributes. Only the invoice’s status can be updated. This method will also change the invoice’s updated_at attribute to the current time.
# delete(id) - delete the Invoice instance with the corresponding id