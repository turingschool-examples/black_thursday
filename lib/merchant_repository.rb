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
			id = row[:id]
			#potential to_sym or to_i (value)
			name = row[:name]
			@merchants[id] = Merchant.new({:id => id, :name => name}, self)
			binding.pry
		end

	end
end

#all search/parsing analytics for the merchants