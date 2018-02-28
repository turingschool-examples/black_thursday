module Repository

  def all
    csv_items
  end

  def inspect
    "#<#{self.class} #{csv_items.size} rows>"
  end

  def find_by_id(id)
    csv_items.find { |csv_item| csv_item.id == id }
  end

  def load_children(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      csv_items << child.new(data, self)
    end
  end
end
