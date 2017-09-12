require 'pry'
require 'csv'

class Merchant
  attr_accessor :id, :name

    def self.id(id)
    CSV.foreach "./lib/merchants.csv", headers: true, header_converters: :symbol
    merch.each do |row|
      id = row[:id]
      puts id
    end

  def initialize(id, name)
    @id = merchant.fetch(:id)
    @name = merchant.fetch(:name)
  end
# end
end

# def name
# end
#
#   # if __FILE__ == $PROGRAM_NAME
#   #   contents = CSV.open "./data/merchants.csv", headers: true, header_converters: :symbol
#   #   contents.each do |row|
#   #     id = row[:id]
#   #     name = row[:name]
#   #     p "#{id}, #{name}"
#   #   end
#   # end


end
