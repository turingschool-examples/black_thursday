require'csv'
require_relative'inspect'
require_relative'transaction'

class TransactionRepository
	attr_reader :transactions, :all, :se
	include Inspect

	def initialize(csv_path, sales_engine)
		@transactions = CSV.open csv_path, headers: true, header_converters: :symbol
		@se = sales_engine
		@all = []
		parse_csv
	end
	
	def parse_csv
		transactions.each { |instances| all << Transaction.new(instances, self) }
	end

	def find_by_id(id)
		all.find {|instance| instance if instance.id == id }
	end

	def find_all_by_invoice_id(invoice_id)
		all.select { |instance| instance if instance.invoice_id == invoice_id}
	end

	def find_all_by_credit_card_number(credit_card_number)
		all.select { |instance| instance if instance.credit_card_number == credit_card_number}
	end

	def find_all_by_result(result)
		all.select { |instance| instance if instance.result == result}
	end
end