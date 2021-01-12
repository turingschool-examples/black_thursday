require "csv"

class ThingRepository
  attr_reader :filename,
              :things,
              :parent

  def initialize(filename, parent)
    @filename = filename
    @parent = parent
    @things = Array.new
    generate_things(filename)
  end

  def generate_things(filename)
    things = CSV.open filename, headers: true, header_converters: :symbol
    things.each do |row|
      @things << Thing.new(row[:id], row[:name], self)
    end
  end

  def all
    @things
  end

  def find_by_id(id)
     id_found = things.find do |thing|
      thing.id == id
    end
  end

  def find_by_name(name)
    name_found = things.find do |thing|
      thing.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    found_things = things.find_all do |thing|
      thing.name.downcase.include?(name.downcase)
    end
  end

  def highest_merchant_id_plus_one
    highest = @things.max do |thing|
      thing.id
    end
    highest.id + 1
  end

  def create(hash)
    new_thing = Thing.new(highest_merchant_id_plus_one, hash[:name], self)
    @things << new_thing
    new_thing
  end

  def update(id, name_hash)
    update_thing = find_by_id(id)
    update_thing.update(name_hash[:name]) if !name_hash[:name].nil?
  end

  def delete(id)
    delete = find_by_id(id)
    @things.delete(delete)
  end

  def inspect
  "#<#{self.class} #{@things.size} rows>"
  end
end
