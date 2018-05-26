require 'csv'
require 'pry'


class FileReader

  def from_csv(path)
    merchants = Hash.new
    CSV.foreach(path, headers:true, header_converters: :symbol) do |row|
      merchants[row[0]] = {
      row.headers[0] => row[0],
      row.headers[1] => row[1],
      row.headers[2] => row[2],
      row.headers[3] => row[3]
    }
    end
    merchants
  end
end

#x = FileReader.new
#puts x.from_csv('./data/merchants.csv')
#ENDING DAY 1.  Able to read in the CSV data for merchants and output the data
#to the terminal where the id is the key and the value is the bject transformed into a hash using the headers as keys and row data as values.
