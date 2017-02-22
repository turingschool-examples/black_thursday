require 'pry'
require 'csv'

class Item

end





  def open_file(file_path)
    file = CSV.open file_path
  end

  def read_csv(file_path)
    contents = CSV.open file_path, headers: true
    contents.each do |row|
      id = row[0]
      puts id
    end
  end
end

i = Item.new
i.read_csv('./test/fixtures/items_one.csv')
