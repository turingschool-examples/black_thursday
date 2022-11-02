require './lib/invoice_repository'
require './lib/invoice'


RSpec.describe InvoiceRepository do
  let!(:invoice_repository) {Invoice.new({})}
end

it 'is a invoice repository class' do
  expect(invoice_repository).to be_a(InvoiceRepository)
end

it 'returns an array of all known invoices' do

end

it 'returns an instance of an invoice with matching id' do

end

it 'returns nil if id is not within' do

end

it 'can find all customers with matching id in an array' do

end

it 'returns nil if not valid customer id' do

end

it 'can find all merchants with matching id in an array' do

end

it 'returns nil if not a valid merchant id' do

end

it 'can return a new invoice instance with attributes' do

end

it 'gives the new invoice instance the highest id + 1' do

end

it 'can update a merchant (by id) with new attributes' do
#will also change the invoices updated_at_attribute to current time
end

it 'can delete an invoice instance by supplied id' do

end
# all - returns an array of all known Invoice instances
# find_by_id - returns either nil or an instance of Invoice with a matching ID
# find_all_by_customer_id - returns either [] or one or more matches which have a matching customer ID
# find_all_by_merchant_id - returns either [] or one or more matches which have a matching merchant ID
# find_all_by_status - returns either [] or one or more matches which have a matching status
# create(attributes) - create a new Invoice instance with the provided attributes. The new Invoice’s id should be the current highest Invoice id plus 1.
# update(id, attribute) - update the Invoice instance with the corresponding id with the provided attributes. Only the invoice’s status can be updated. This method will also change the invoice’s updated_at attribute to the current time.
# delete(id) - delete the Invoice instance with the corresponding id