require 'time'

class Repository
  class Record

    def self.singular
      name.to_s.downcase
    end

    def self.plural
      singular + 's'
    end

    attr_reader :id, :created_at, :updated_at, :repo
    def initialize(repo, fields)
      raise "Repository::Record must be subclassed" if self.class == Repository::Record
      @repo = repo
      @id = (fields[:id] || repo.unused_id).to_i

      @created_at = if fields.key? :created_at
        Time.parse(fields[:created_at])
      else
        Time.now
      end

      @updated_at = if fields.key? :updated_at
        Time.parse(fields[:updated_at])
      else
        Time.now
      end

    end

    def foreign_id(record_class)
      field = record_class.singular + '_id'
      send(field.to_sym)
    end

  end
end
