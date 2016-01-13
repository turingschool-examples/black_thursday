require 'pry'
require 'csv'

class MerchantRepository
  attr_reader :merchants

  def initialize(merchants)
    @merchants = merchants
  end

  def parse_merchants
    # binding.pry
    @merchants[0].each do |row|
      @id = row[:id]
      @name = row[:name]
      # puts "#{@id_column}: #{@name_column}"
      merchants = Hash[@id, @name]
      # create Merchant.new(#id, #column)
      puts merchants
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
# mr = MerchantRepository.new('./data/merchants.csv')
# merchant_list = mr.load_data('./data/merchants.csv')
# mr.find_id(12334105)
# puts mr.parse_data(12334105)

end
