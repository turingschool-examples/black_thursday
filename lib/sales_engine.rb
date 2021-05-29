class SalesEngine

  def self.from_csv(data)
    @items = data[:items]
    @merchants = data[:merchants]
  end
end
