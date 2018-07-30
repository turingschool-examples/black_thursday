# frozen_string_literal: true

# Repository helper methods
module RepositoryHelper
  def populate(data)
    data.map do |row|
      create(row)
    end
  end

  def find_by_id(id)
    return nil unless @repository.key?(id)
    @repository.fetch(id)
  end

  def delete(id)
    @repository.delete(id)
  end

  def remove_keys(data, type)
    data.keep_if do |element|
      element.is_a?(type)
    end
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end
end
