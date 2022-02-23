require 'csv'
require 'pry'

class SalesEngine
  attr_reader :items, :merchants

  def self.from_csv(argument)
    @items = argument[:items]
    @merchants = argument[:merchants]
  end


  # def load_data(data_csv, header)
  #   rows = CSV.read(data_csv, headers: true)
  #     rows.find_all do |element|
  #       if element[header] == name
  #         result << element
  #       end
  #     end
  #   result
  # end

end
