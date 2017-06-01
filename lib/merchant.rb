
class Merchant

  attr_reader :information

  def initialize(information, parent)
    @information = information
    @parent      = parent
  end

  def name
    information["name"]
  end

  def id
    information["id"].to_i
  end

end
