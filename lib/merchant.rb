class Merchant

  attr_reader :id,
              :name

  def initialize(merch_hash)
    @id = merch_hash[:id].to_i
    @name = merch_hash[:name]
  end

  def update_info(attributes)
    attributes.each do |key, value|
      if key == :name
        @name = value
      end
    end
  end
end
