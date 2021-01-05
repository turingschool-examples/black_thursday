class Merchant
  attr_reader :data,
              :id,
              :name

  def initialize (data)
    @id = data[:id]
    @name = data[:name]
  end 


end
