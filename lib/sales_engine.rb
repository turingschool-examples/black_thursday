class SalesEngine
  attr_reader :items_file,
              :merchants_file

  def initialize(file_path_hash)
    @items_file = file_path_hash[:items]
    @merchants_file = file_path_hash[:merchants]
  end

  def self.from_csv(file_path_hash)
    SalesEngine.new(file_path_hash)
  end

  def merchants
    csv_converter(@merchants_file)

  end

  def items
    hash = csv_converter(@items_file)
  end

  def csv_converter(file_path)
    csv_objs = CSV.read(file_path, {headers: true, header_converters: :symbol})
    csv_objs.map do |obj|
      obj[:id] = obj[:id].to_i
      hash = obj.to_h
    end
  end
end
