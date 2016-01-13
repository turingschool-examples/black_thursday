require './lib/merchant_repository'
require 'pry'
require 'csv'

class SalesEngine

  def self.from_csv(hash_of_csv_files)
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

    puts contents
    # binding.pry
    mr = MerchantRepository.new(contents)
    mr.parse_merchants
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
# se = SalesEngine.new
# se.from_csv({:merchants => './data/merchants.csv',
#              :items => './data/items.csv'})

se = SalesEngine.from_csv({:merchants => './data/merchants.csv'})

end
