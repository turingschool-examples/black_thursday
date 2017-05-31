class Merchant

  attr_reader :name,
              :id

  def initialize(params = {})
    @name = params.fetch(:name, "")
    @id   = params.fetch(:id, "")
  end

end
