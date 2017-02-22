require_relative'item_repository'
require_relative'merchant_repository'


class SalesEngine

	def self.from_csv(data_paths)
    @items = ItemRepository.new(data_paths[:items], self)
    @merchants = MerchantRepository.new(data_paths[:merchants], self)
		self
	end

	def self.items
		@items
	end

	def self.merchants
		@merchants
	end


end