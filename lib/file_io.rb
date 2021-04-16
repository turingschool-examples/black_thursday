class FileIo
  def self.process_csv(filename, type)
    elements = []
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      elements << type.new(row)
    end
    elements
  end
end
