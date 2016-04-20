require 'csv'

class CsvParser

  def merchants(merchants)
    contents = CSV.open merchants, headers: true, header_converters: :symbol
    id = []
    name = []
    contents.each do |row|
      id << row[:id]
      name << row[:name]
    end
    array = id.zip(name).to_h.map do |id, name|
      { :id => id, :name => name }
    end
    array
  end


  def items(items)
    contents = CSV.open items, headers: true, header_converters: :symbol
    array = []
    contents.each do |row|
      hash = {:id => row[:id],
      :name => row[:name],
      :description => clean_item_description(row[:description]),
      :created_at => row[:created_at],
      :updated_at => row[:updated_at],
      :merchant_id => row[:merchant_id]}
      array << hash
    end
     array
  end


  def clean_item_description(description)
    description.gsub!("\n", " ")
  end


end
