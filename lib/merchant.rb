class Merchant
	attr_reader :id, :name, :parent

	def initialize(data, parent)
		@id = data[:id]
		@name = data[:name]
		@parent = parent
	end
	
end
