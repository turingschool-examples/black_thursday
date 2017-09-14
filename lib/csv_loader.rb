require 'csv'

module CsvLoader

  def load_csv(csv_file_path)
    CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
  end

  def create_instances(csv_file_path, class_name, engine)
    csv = load_csv(csv_file_path)
    csv.map do |row|
       Module.const_get(class_name).new(row, engine)
    end
  end
end
