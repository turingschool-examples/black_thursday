module CreateElements

  def create_elements(file)
    CSV.readlines(file, headers: true, header_converters: :symbol) do |row|
      row
    end
  end

end
