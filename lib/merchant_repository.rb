require 'pry'
require 'csv'

class MerchantRepository
  attr_reader :file, :id_column

  def initialize(file=nil)
    @file = file
  end

  def load_data(file)
    CSV.open file, headers: true, header_converters: :symbol
  end

  def parse_data(file, id)
    contents = load_data(file)
    contents.each do |row|
      @id_column = row[:id]
      @name_column = row[:name]

      # binding.pry


      if @id_column.include?(id.to_s)
        puts id
      elsif id.nil?
        puts "nil"
      end
    end
  end

  def all
    ['name_one', 'name_two']
  end

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
merchant_list = mr.load_data('./data/merchants.csv')
# mr.find_id(12334105)
mr.parse_data('./data/merchants.csv', 12334105)
end
