require 'csv'

class ItemRepository

  def initialize(path)
    @path = path
  end

  def self.all
    rows = CSV.read(@@filename, headers: true)

    result = rows.map do |row|
      row
    end
  end
end
