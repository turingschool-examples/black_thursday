class Invoice
  attr_reader :id, :name
  def initialize(data, repo = nil)
    @id = data[:id].to_i
    @name = data[:name]
    @parent = repo
  end
end
