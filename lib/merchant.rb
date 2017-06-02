
class Merchant

  attr_reader :name,
              :created_at,
              :id,
              :updated_at


  def initialize(data, parent)
      @name = data[:name]
      @id = data[:id].to_i
      @created_at = date_convert(data[:created_at])
      @updated_at = date_convert(data[:updated_at])
  end

  def date_convert(from_file)
    date = from_file.split("-")
    time = Time.new(date[0], date[1], date[2])
  end
  
end
