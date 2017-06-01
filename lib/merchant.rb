
class Merchant

  attr_reader :name,
              # :id,
              :created_at,
              :updated_at


  def initialize(data, parent)
      @name = data[:name]
      # @id   = data[:id]
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
  end



  # def initialize(information, parent)
  #   @information = information
  #   @parent      = parent
  # end

  # def name
  #   information["name"]
  # end
  #
  # def id
  #   information["id"].to_i
  # end
  #
  # def created_at
  #   information["created_at"]
  # end
  #
  # def updated_at
  #   information["updated_at"]
  # end

end
