class Merchant
  attr_accessor :id,
              :name,
              :created_at,
              :updated_at
  attr_reader :repo

  def initialize(data, repo)
    @data = data
    @repo = repo
    @id = data[:id]
    @name = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  # def update(attribute)
  #   if attribute[:id] == nil
  #     @updated_at = Time.now
  #     if attribute[:name] != nil
  #       @name = attribute[:name]
  #     elsif attribute[:repo] != nil
  #       @repo == attribute[:repo]
  #     end
  #   end
  # end

  def update(attributes)
    @name        = attributes[:name] if attributes[:name]
    @repo        = attributes[:repo] if attributes[:repo]
    @updated_at  = Time.now
  end
end
