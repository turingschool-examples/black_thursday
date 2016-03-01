require 'pry'

class Merchant
  def initialize(row_from_csv)
    @row_from_csv = row_from_csv
  end

  def id
    @row_from_csv[:id]
  end

  def name
    @row_from_csv[:name]
  end
end
