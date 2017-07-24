require 'csv'

class ItemRespoitory
  def csv_reader(path)
    contents = CSV.open pathname, headers: true, header_converters: :symbol
    contents.each do |data|
      # item.add_data(data)
    end
  end

end
