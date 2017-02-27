require_relative'customer'
require_relative'inspect'
require'csv'

class CustomerRepository
	attr_reader :se, :all, :customers
	include Inspect

	def initialize(csv_path, sales_engine)
		@customers = CSV.open csv_path, headers: true, header_converters: :symbol
		@se = sales_engine
		@all = Array.new
		parse_csv
	end

	def parse_csv
		customers.each {|instances| all << Customer.new(instances, self) }
	end

	def find_by_id(id)
		all.find { |instance| instance if instance.id == id}
	end

	def find_all_by_first_name(fn)
		all.select { |instance| instance if instance.first_name.downcase.include?(fn.downcase) }
	end

	def find_all_by_last_name(ln)
		all.select { |instance| instance if instance.last_name.downcase.include?(ln.downcase) }
	end
end