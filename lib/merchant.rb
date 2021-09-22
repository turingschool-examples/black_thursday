class Merchant

  attr_reader :id,
              :name

  attr_accessor :total_revenue

  def initialize(merch_hash)
    @id = merch_hash[:id].to_i
    @name = merch_hash[:name]
    @total_revenue = 0
  end

  def update_info(attributes)
    attributes.each do |key, value|
      @name = value if key == :name
    end
  end
end
