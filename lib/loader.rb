module Loader

  def load_data(csvfile)
    CSV.open csvfile, headers: true, header_converters: :symbol
  end

end
