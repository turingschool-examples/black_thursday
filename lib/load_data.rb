
module LoadData
  extend self
  def load_data(data)
    contents = CSV.open data, headers: true, header_converters: :symbol
    contents.to_a.map {|row| row.to_hash}
  end

end
