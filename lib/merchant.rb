class Merchant
	attr_reader :merchant_info, :mr_instance
	def initialize(merchant_info, mr_instance)
		@merchant_info = merchant_info
		@mr_instance = mr_instance
	end
	
	def name
		#call this instead of hash for refactor
		merchant_info[:name]
	end

	def id
		merchant_info[:id]
	end
end