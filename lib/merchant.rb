class Merchant

  attr_reader :id, :name

  def initialize(id_name_hash)
    @id = id_name_hash[:id].to_i
    @name = id_name_hash[:name].downcase
  end

end
