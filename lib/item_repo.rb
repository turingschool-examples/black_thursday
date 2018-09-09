class ItemRepo < CsvAdaptor

  attr_reader :data_file,
              :items

  def initialize(data_file)
    @data_file = data_file
    @items = []
  end

  def all_item_characteristics(data_file)
    load_items(data_file)
  end

  def all
    load_items(data_file).each do |item_info|
      @items << Item.new(item_info)
    end
    @items
  end

  def find_by_id(id)
    @items.each do |item|
      if item.id == id
        return item
      end
    end
    nil
  end

  def find_by_name(name)
    @items.each do |item|
      if item.name == name
        return item
      end
    end
    nil
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase.include? description.downcase
    end
  end

end
