class Merchant
  attr_reader :id, :updated_at, :created_at
  attr_accessor :name

  def initialize(stats)
    @id = stats[:id].to_i
    @name = stats[:name]
    @created_at = check_created_at(stats[:created_at])
    @updated_at = check_updated_at(stats[:updated_at])
  end

  def check_created_at(created_at)
    if created_at
      @created_at = created_at
    else
      @created_at = Time.now.strftime("%Y-%m-%d")
    end
  end

  def check_updated_at(updated_at)
    if updated_at
      @updated_at = updated_at
    else
      @updated_at = Time.now.strftime("%Y-%m-%d")
    end
  end
end
