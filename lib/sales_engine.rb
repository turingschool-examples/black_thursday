require './lib/merchant_repository'
require 'csv'

class SalesEngine
  attr_reader :file, :command, :value

  def initialize(*file)
    @file = file
    # @command = command
    # @value = value
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
se = SalesEngine.new('./data/merchants.csv')
puts se.delegate(find_id, 12334105)
# mr.find_id(12334105)
# puts mr.find_id(12334104)
# puts se.merchants.find_id("CJsDecor")
end
