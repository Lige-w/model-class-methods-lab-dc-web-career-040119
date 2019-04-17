class Captain < ActiveRecord::Base
  has_many :boats

  def boat_types
    boats.map { |boat| boat.classifications }.flatten.uniq
  end

  def self.catamaran_operators
    all.select do |captain|
      captain.boat_types.include?(Classification.find_by(name: 'Catamaran'))
    end
  end

  def self.sailors
    Boat.sailboats_with_captain.map {|sailboat| sailboat.captain }.uniq
  end

  def self.motorists
    all.select do |captain|
      captain.boat_types.include?(Classification.find_by(name: 'Motorboat'))
    end
  end

  def self.talented_seafarers
    all.select do |captain|
      sailors.include?(captain) && motorists.include?(captain)
    end
  end

  def self.non_sailors
    all.reject do |captain|
      captain.boat_types.include?(Classification.find_by(name: 'Sailboat'))
    end
  end
end
