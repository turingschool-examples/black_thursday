class Merchant
  attr_reader     :id,
                  :created_at,
                  :name

  def initialize(data)
    @id         = data[:id].to_i
    @name       = data[:name]
    @created_at = data[:created_at]
  end

  def update_name(name)
    @name = name
  end
end
