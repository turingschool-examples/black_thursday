require './lib/merchant'
require 'csv'
require 'pry'
class MerchantRepository
	attr_reader :file, :merchants
	def initialize(file, sales_engine_instance)
		@file = file
		@sales_engine_instance = sales_engine_instance
		@merchants = Hash.new(0)
	end

	def open_contents
		CSV.open(file, headers: true, header_converters: :symbol)
	end

	def merchant_maker
		open_contents.each do |row|
			id = row[:id].to_i
			#potential to_sym or to_i (value)
			name = row[:name]
			@merchants[id] = Merchant.new({:id => id, :name => name.upcase}, self)
		end
		# @merchants
	end

	def all
		@merchants.values
		# binding.pry
	end

	def find_by_id(id)
		@merchants.has_key?(id) ? @merchants[id] : nil
		# binding.pry
	end

	def find_by_name(naming)
		found_merchant = all.detect do |merchant|
			merchant.merchant_info[:name] == naming.upcase
		end
		found_merchant
	end

	def find_all_by_name(fragment)
		found_names = @merchants.values.map do |merchant|
				# binding.pry
			if merchant.merchant_info[:name].include?(fragment.upcase) 
				merchant.merchant_info[:name]
			end
		end
		found_names.compact
	end


	# def find_by_name(name)
	# 	if all.any? { |merchant| merchant.merchant_info[:name] == name }
	# 	end
	# 	name.upcase
	# end
end

#all search/parsing analytics for the merchants