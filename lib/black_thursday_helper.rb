require 'CSV'
require 'pry'
module Black_Thursday_Helper

  def populate(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @merchants << Merchant.new(data)
    end
  end

  def populate(filepath)
      csv_objects = CSV.open(filepath, headers: true, header_converters: :symbol)
      csv_objects.map do |object|
        object[:id] = object[:id].to_i
      collection << object.to_h
    end
  end

end
