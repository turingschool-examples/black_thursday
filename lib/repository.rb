# Repositoyr module
module Repository
  attr_reader :contents

  def load_path(path)
    CSV.foreach path, headers: true, header_converters: :symbol do |row|
      @contents[row[:id].to_i] = Item.new(row, self)
    end
  end

  def all
    @contents.values
  end

  def find_by_id(id)
    @contents[id]
  end

  def find_by_name(name)
    all.find { |item| item.name.downcase == name.downcase }
  end
end
