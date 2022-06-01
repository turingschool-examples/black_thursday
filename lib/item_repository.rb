require 'csv'

class ItemRepository
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Item.new({
        id: row[:id], name: row[:name], description: row[:description], unit_price: row[:unit_price], merchant_id: row[:merchant_id], created_at: row[:created_at], updated_at: row[:updated_at]})
    end
  end

  def find_by_id(id)
    @all.find {|row| row.id == id}
  end

  def find_by_name(name)
    @all.find {|row| row.name.downcase == name.downcase}
  end

  def find_all_with_description(description)
    @all.find_all {|row| row.description.include?(description)}
  end

  def find_all_by_price
    @all.find_all {|row| row.description.include?(description)}
  end
end
