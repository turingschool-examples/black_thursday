require 'pry'
require 'csv'

class MerchantRepository
  attr_reader :file, :id_column

  def initialize(file=nil)
    @file = file
  end

  def parse_data(id)
    contents = CSV.open @file, headers: true, header_converters: :symbol
    contents.each do |row|
      @id_column = row[:id]
      @name_column = row[:name]

      if @id_column.include?(id.to_s)
        return id
      else
        # return nil
        return "nil"
      end
    end
  end

  # def find_by_id(id)
  #   if @id_column.include?(id.to_s)
  #     return id
  #   else
  #     return "nil"
  #   end
  # end

  # def all
  #   ['name_one', 'name_two']
  # end

  # def find_id(id)
  #   @id_column.include?(id.to_s)
  #   if id.nil?
  #     nil
  #   else
  #     puts id
  #   end
  # end


end

if __FILE__ == $0
mr = MerchantRepository.new('./data/merchants.csv')
# merchant_list = mr.load_data('./data/merchants.csv')
# mr.find_id(12334105)
puts mr.parse_data(12334105)

end
