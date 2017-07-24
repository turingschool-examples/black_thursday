class SalesEngine
  attr_reader :files

  def initialize
    @files = nil
  end

  def from_csv(csv_hash)
    @files = csv_hash
  end
end
