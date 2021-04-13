require 'CSV'

class SalesEngine
  attr_reader :merchants, :items
  def initialize(csv_data)
    @merchants = csv_data[:merchants]
    @items = csv_data[:items]
  end

  def self.from_csv(csv_data)
    SalesEngine.new(csv_data)
  end

  def self.parse_csv(path)
    parsed_csv = CSV.parse(File.read(path), headers: true, header_converters: :symbol).to_a
    headers = parsed_csv.shift
    repo = []
    parsed_csv.each do |data|
      new_hash = Hash.new
      counter = 0
      headers.each do |header|
        new_hash[header] = data[counter]
        counter += 1
      end
      repo << new_hash
    end
    repo
  end

  def merchants
    MerchantRepository.new(SalesEngine.parse_csv(@merchants))
  end

  def items
    ItemRepository.new
  end
end






#
# needs to intake the files and then make them usable by both merchant repo and item repo. intake files from_csv method.
#
# items method will return an instance of item repository. item repository will have all of the items in it.
#
# merchant method will return an instance of merchant repository. merchant repository gets created with all of the merchant objects



# Leigh's group project
# class StatTracker
#   attr_reader :games_data,
#               :team_data,
#               :game_teams_data,
#               :game_manager,
#               :game_team_manager,
#               :team_manager
#
#   def initialize(locations)
#     load_manager(locations)
#   end
#
#   def self.from_csv(locations)
#     StatTracker.new(locations)
#   end
#
#   def load_manager(locations)
#    @team_manager = TeamManager.new(load_csv(locations[:teams]), self)
#    @game_manager = GameManager.new(load_csv(locations[:games]), self)
#    @game_team_manager = GameTeamsManager.new(load_csv(locations[:game_teams]), self)
#   end
#
#   def load_csv(path)
#     CSV.parse(File.read(path), headers: true, header_converters: :symbol)
#   end
