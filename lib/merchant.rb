class Merchant
	attr_reader :data

	def initialize(data, parent)
		@data = data
		@parent = parent
	end

end
