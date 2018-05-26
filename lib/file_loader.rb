require 'csv'

module FileLoader

  def open_items_csv
    items = CSV.open('items.csv')
  end

end
