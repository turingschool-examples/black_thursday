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
      @repo = repo
      @id = fields[:id].to_i
      @created_at = ensure_time(fields[:created_at])
      @updated_at = ensure_time(fields[:updated_at])
    end

    def ensure_time(given)
      if given.nil?
        Time.now
      else
        Time.parse(given)
      end
    end

    def foreign_id(record_class)
      field = record_class.singular + '_id'
      send(field.to_sym)
    end

  end
end
