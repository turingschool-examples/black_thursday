class Repository
  attr_reader :repo

  def initialize
    @repo = []
  end

  def all
    @repo
  end

  def parse_data(file, class_var)
    rows = CSV.open file, headers: true, header_converters: :symbol
    rows.each do |row|
      new_obj = class_var.new(row.to_h)
      @repo << new_obj
    end
  end

  def new_id(attributes)
    unless @repo.empty?
      attributes[:id] = all.max do |item|
        item.id
      end.id + 1
    end
  end

  def find_by_id(id)
    @repo.find { |item| item.id == id }
  end

  def update(id, attributes)
    find_by_id(id).update(attributes) if find_by_id(id)
  end

  def delete(id)
    @repo.delete_if { |item| item.id == id }
  end

  def inspect
    "#<#{self.class} #{@repo.size} rows>"
  end
end