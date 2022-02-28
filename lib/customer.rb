require 'time'

class Customer
  attr_accessor :id,
                :first_name,
                :last_name,
                :created_at,
                :updated_at

  def initialize(info_hash)
    @id = info_hash[:id]
    @first_name = info_hash[:first_name]
    @last_name = info_hash[:last_name]
    @created_at = info_hash[:created_at]
    @updated_at = info_hash[:updated_at]
  end

  def update(attributes)
    attributes[:updated_at] = Time.now
    @first_name = attributes[:first_name] || @first_name
    @last_name = attributes[:last_name] || @last_name
    @updated_at = attributes[:updated_at]
  end
end
