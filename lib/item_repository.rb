require_relative 'helper_methods'

class ItemRepository
  include HelperMethods
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path.to_s
    @all = Array.new
    data = CSV.parse(File.read(@file_path), headers: true) do |line|
      @all << line.to_h
    end
  end

  # add more attributes to method
  def create(attributes)
    Item.new({
      :id => create_new_id,
      :name => attributes[:name]
      })
  end

  def update(id, attributes)
    result = find_by_id(id)
    result['name'] = attributes[:name]
    result['description'] = attributes[:description]
    result['unit_price'] = attributes[:unit_price]
  end

end
