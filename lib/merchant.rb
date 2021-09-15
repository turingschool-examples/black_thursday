class Merchant
  attr_reader :id
  attr_accessor :name

  def initialize(info)
    @id   = info[:id].to_i
    @name = info[:name]
  end

  def change_name(name)
    @name = name
  end
end
