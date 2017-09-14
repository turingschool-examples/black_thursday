class Repository
  class Record

    attr_reader :id, :created_at, :updated_at, :repo
    def initialize(repo, fields)
      raise "Repository::Record must be subclassed" if self.class == Repository::Record
      apply_defaults(fields)
      @repo = repo
    end

    def foreign_id(type)
      type_singular = type.to_s[0..-2]
      key = type_singular + '_id'
      send(key.to_sym)
    end

    def apply_defaults(fields)
      fields[:id]         ||= repo.unused_id
      fields[:created_at] ||= Time.now
      fields[:updated_at] ||= Time.now
    end

    def ==(other)
      @id == other.id
    end

  end
end
