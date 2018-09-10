class Item
	attr_reader :data

	def initialize(data)
		@data = data
	end

	def id
		data[:id]
	end

end
