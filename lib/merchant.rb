

class Merchant

  attr_reader :id, :name

  def initialize(mr, csv_info)
    @id = csv_info[:id].to_s.to_i
    @name = csv_info[:name]
  end

  def items
  end

end
