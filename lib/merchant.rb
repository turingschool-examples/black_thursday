class Merchant
	attr_reader :id, :parent
	attr_accessor :name, :created_at, :updated_at

	def initialize(data, parent)
		@id         = data[:id]
		@name       = data[:name]
		@parent     = parent
		@created_at = data[:created_at]
		@updated_at = data[:updated_at]
	end

end
