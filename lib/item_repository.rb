require 'csv'

class ItemRepository
  def initialize(csv)

  end

  def self.read_file
    @csv = CSV.read(csv, headers: true)
  end
end
