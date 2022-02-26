require 'csv'
require_relative 'item'
require 'pry'

class ItemRepository
  attr_reader :items
  # attr_accessor :id

  def inspect
    "#<\#{self.class} \#{@items.size} rows>"
  end

  def initialize(data)
    @items =[]
    CSV.foreach(data, headers: true, header_converters: :symbol) do |row| header ||= row.headers
      @items << Item.new(row)
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find {|item| item.id == id}
  end

  def find_by_name(name)
    @items.find {|item| item.name == name.downcase}
  end

  def find_all_by_name(fragment)
    @items.find_all {|item| item.name.downcase.include?(fragment.downcase)}
  end

  def create(new_name)
    id = @items[-1].id + 1
    name = new_name[:name]
    new_item = Item.new({id: id, name: name, created_at: Time.now, updated_at: Time.now})
    @items << new_item
    new_merch
  end

  def update(id, attribute)
    if attribute.keys.include?(:name) == true
        if find_by_id(id) != nil
            item = find_by_id(id)
            item.name = attribute[:name]
            item.updated_at = Time.now
          end
      end
    item
  end

  def delete(id)
    @items.delete(find_by_id(id)) if find_by_id(id) != nil
  end
end
