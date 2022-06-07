require './lib/customer'
require 'time'

RSpec.describe Customer do

	it 'exists' do
		c = Customer.new({
  :id => 6,
  :first_name => "Joan",
  :last_name => "Clarke",
  :created_at => Time.now,
  :updated_at => Time.now
})
	end
end
