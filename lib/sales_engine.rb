require './lib/merchant_repository'
require 'csv'

class SalesEngine
  # attr_reader :file, :command, :value

  def initialize

  end

  def from_csv(hash_of_csv_files)
    key_list = hash_of_csv_files.keys
    puts key_list
    value_list = hash_of_csv_files.values
    puts value_list

    contents = [] # map?
    hash_of_csv_files.each do |key, value|
      key = CSV.open value, headers: true, header_converters: :symbol
      contents << key
    end

    # contents = CSV.open file, headers: true, header_converters: :symbol
    puts contents
    contents[0].each do |row|
      @id_column = row[:id]
      @name_column = row[:name]
      # puts "#{@id_column}: #{@name_column}"
      merchants = Hash[@id_column, @name_column]
      puts merchants
    end
  end

  def delegate(command, value)
    # assign controller variable to Controller.new
    # give controller [file, command and value]
    # controller uses those to:
        # load file
        # initialize relevant class
        # finds the relevant method in said class
        # gives method the provided value
        # returns method result

    controller = MerchantRepository.new
    # finder = command(value)

    content = controller.find_id(value)
    puts content
  end

end

if __FILE__ == $0
# se = SalesEngine.new('./data/merchants.csv')
# puts se.delegate(find_id, 12334105)
# # mr.find_id(12334105)
# # puts mr.find_id(12334104)
# # puts se.merchants.find_id("CJsDecor")

se = SalesEngine.new
se.from_csv({:merchants => './data/merchants.csv',
            :items => './data/items.csv'})
# mr.find_id(12334105)
# puts mr.find_id(12334104)
# puts se.merchants.find_id("CJsDecor")
end
