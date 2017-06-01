

class Invoice

  attr_reader :information,
              :parent

  def initialize(information, parent)
    @information = information
    @parent = parent
  end

end
