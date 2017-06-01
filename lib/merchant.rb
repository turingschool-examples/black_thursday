
class Merchant

  attr_reader :name,
              :created_at,
              :id,
              :updated_at


  def initialize(data, parent)
      @name = data[:name]
      @id = data[:id].to_i
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
  end

end
