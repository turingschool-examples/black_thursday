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

		expect(c).to be_an_instance_of Customer
	end

	it 'can return the customer id' do
		c = Customer.new({
		:id => 6,
		:first_name => "Joan",
		:last_name => "Clarke",
		:created_at => Time.now,
		:updated_at => Time.now
		})

		expect(c.id).to eq(6)

	end

	it 'can return the customers first name' do
		c = Customer.new({
		:id => 6,
		:first_name => "Joan",
		:last_name => "Clarke",
		:created_at => Time.now,
		:updated_at => Time.now
		})

		expect(c.first_name).to eq("Joan")
	end

	it 'can return the customers last name' do
		c = Customer.new({
		:id => 6,
		:first_name => "Joan",
		:last_name => "Clarke",
		:created_at => Time.now,
		:updated_at => Time.now
		})

		expect(c.last_name).to eq("Clarke")

	end

	it 'can return the time the customers profile was created' do
		c = Customer.new({
		:id => 6,
		:first_name => "Joan",
		:last_name => "Clarke",
		:created_at => Time.now.round,
		:updated_at => Time.now.round
		})

		expect(c.created_at).to eq(Time.now.round)
	end

	it 'can return the time the customers profile was updated' do
		c = Customer.new({
		:id => 6,
		:first_name => "Joan",
		:last_name => "Clarke",
		:created_at => Time.now.round,
		:updated_at => Time.now.round
		})

		expect(c.updated_at).to eq(Time.now.round)
	end
end
