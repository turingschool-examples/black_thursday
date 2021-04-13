class SalesEngine
  def self.from_csv(files)
    SalesEngine.new(files)
  end
  private

  def initialize(files)
    load_items(files[:items])
    load_merchants(files[:merchants])
  end
end
