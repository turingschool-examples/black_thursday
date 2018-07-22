require_relative 'item.rb'
require_relative 'repo_helper'

class ItemRepository
  include RepoHelper
  attr_reader :repo

  def initialize(file_contents)
    @repo = file_contents.map do |item|
      Item.new(item)
    end
  end




end
