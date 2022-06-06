require_relative 'entry'
class MerchantRepository
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(
        :id => row[:id].to_i,
        :name => row[:name]
        )
    end
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_by_id(id)
    @all.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    @all.find {|merchant| merchant.name.upcase == name.upcase}
  end

  def find_all_by_name(name_fragment)
    @all.find_all {|merchant| merchant.name.upcase.include?(name_fragment.upcase)}
  end

  def create(attributes)
    create_id = (@all.last.id + 1)
    @all << Merchant.new({
      :id => create_id,
      :name => attributes[:name]
      })
  end

  def update(id, attributes)
    update_id = find_by_id(id)
    update_id.name = attributes[:name]
  end

  def delete(id)
    delete_id = find_by_id(id)
    @all.delete(delete_id)
  end

end
