require './lib/merchant_repository'
require 'pry'
require 'csv'

class SalesEngine

  def from_csv(hash_of_csv_files)
    puts hash_of_csv_files
    puts hash_of_csv_files.keys
    puts hash_of_csv_files.values
    # if loop on count, to split out the different key/value pairs
    puts hash_of_csv_files.count
    # => create (.count) many arrays, named after keys

    contents = [] # map?
    hash_of_csv_files.each do |key, value|
      key = CSV.open value, headers: true, header_converters: :symbol
      contents << key
    end

    # contents = CSV.open file, headers: true, header_converters: :symbol
    puts contents

    # binding.pry

    mr = MerchantRepository.new(contents)
    mr.parse_merchants
    # contents[0].each do |row|
    #   @id_column = row[:id]
    #   @name_column = row[:name]
    #   # puts "#{@id_column}: #{@name_column}"
    #   merchants = Hash[@id_column, @name_column]
    #   puts merchants
    # end
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

# se = SalesEngine.new
# se.from_csv({:merchants => './data/merchants.csv',
#              :items => './data/items.csv'})

se = SalesEngine.new
se.from_csv({:merchants => './data/merchants.csv'})

# mr.find_id(12334105)
# puts mr.find_id(12334104)
# puts se.merchants.find_id("CJsDecor")
end
