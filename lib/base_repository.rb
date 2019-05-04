# frozen_string_literal: true

# this is a BaseRepository Baseclass
class BaseRepository
  attr_reader :raw_data, :models

  def initialize(raw_data)
    @raw_data = raw_data
  end

  def all
    models
  end

  def find_by_id(id)
    models.find { |model| model.id == id }
  end

  def find_by_name(name)
    models.find { |model| model.name.downcase == name.downcase }
  end

  def delete(id)
    to_delete = find_by_id(id)
    models.delete(to_delete)
  end

  def inspect
    "#<#{self.class} #{models.size} rows>"
  end
end
