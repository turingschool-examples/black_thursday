# frozen_string_literal: true

# base repo
class BaseRepository
  attr_reader :csv_table_data, :models

  def initialize(csv_table_data, parent)
    @engine = parent
    @csv_table_data = csv_table_data
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

  def find_highest_id
    models.map(&:id).max
  end

  def create_new_id
    find_highest_id + 1
  end

  def inspect
    "#<#{self.class} #{models.size} rows>"
  end
end
