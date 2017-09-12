#works - 4pm, 9/12

class Merchant

  attr_reader :id, :name

  def initialize(csv_info)
      @id = csv_info[:id]
    @name = csv_info[:name]
  end

end
