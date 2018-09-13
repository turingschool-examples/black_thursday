class Merchant
	attr_reader :id, :parent
	attr_accessor :name

	def initialize(data, parent)
		@id = data[:id]
		@name = data[:name]
		@parent = parent
	end

end
