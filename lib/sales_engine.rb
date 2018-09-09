
require 'csv'

class SalesEngine
	attr_reader :collection

  	def initialize(files)
  	  @files = files
  	end

    def self.from_csv(filepath)
      @collection = []

      csv_objects = CSV.open(filepath, headers: true, header_converters: :symbol)
      csv_objects.map do |object|
        object[:id] = object[:id].to_i
        @collection << object.to_h
      end
    end

end
