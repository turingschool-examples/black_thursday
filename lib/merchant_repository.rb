# require './data/merchants.csv'
require 'csv'

class MerchantRepository

  attr_reader     :all

  def initialize
    @all = []
  end

  def populate(filename)
    contents = CSV.open(filename, headers: true,
     header_converters: :symbol)

    contents.each do |row|
      @all << Merchant.new(row)
    end

  end



  # def load_attendees(csv_path = "full_event_attendees.csv")
  #   @attendees = Reader.new(csv_path).content
  #   "You have successfully loaded #{csv_path}"
  # end

end
