require "csv"
require "pry"

class SalesEngine



  def self.from_csv(files_to_load)
    @items ||= CSV.open "#{files_to_load[:items]}" #, headers:true, header_converters: :symbol
  end



end
