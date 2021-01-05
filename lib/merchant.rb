class Merchant
  attr_reader :id,
              :name
  def initialize(id, name)
    @id = id.to_i
    @name = name
  end

  # def create(args)
  #   @merchants << merchant.new({:id => highest_merchant_id_plus_one,
  #                 :args[:name] => ?)
  # end

  def update(name)
    @name = name
  end

  def delete(id)
    delete = @merchants.find do |merchant|
      merchant[:id] = id
    end
    @merchants.delete(delete)
  end
end
