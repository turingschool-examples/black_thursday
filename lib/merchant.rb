class Merchant

  attr_reader :id

  attr_accessor :name,
                :updated_at

  def initialize(info)
    @id = info[:id].to_i
    @name = info[:name]
    @created_at = Time.parse(info[:created_at].to_s)
    @updated_at = Time.parse(info[:updated_at].to_s)
  end
end
