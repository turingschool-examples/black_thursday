# frozen_string_literal: true

# Repository helper methods
module RepositoryHelper
  def populate(data)
    data.map do |row|
      create(row)
    end
  end

  def remove_keys(data, type)
    data.keep_if do |element|
      element.is_a?(type)
    end
  end
end
