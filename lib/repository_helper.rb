# frozen_string_literal: true

# Repository helper methods
module RepositoryHelper
  def populate(data)
    data.map do |row|
      create(row)
    end
  end

  def create(params)
    params[:id] = @repository.max[0] + 1 if params[:id].nil?

    sub_class.new(params).tap do |new_object|
      @repository[params[:id].to_i] = new_object
    end
  end

  def find_by_id(id)
    return nil unless @repository.key?(id)
    @repository.fetch(id)
  end

  def find_by_name(name)
    all.find do |repository|
      repository.name.downcase == name.downcase
    end
  end

  def all
    repository_pairs = @repository.to_a.flatten
    remove_keys(repository_pairs, sub_class)
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
