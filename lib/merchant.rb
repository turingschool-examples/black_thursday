class Merchant

  attr_reader     :id,
                  :created_at
  attr_accessor   :name

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @created_at = attributes[:created_at]
  end


end
