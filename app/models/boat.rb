class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    first(5)
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length >= 20")
  end

  def self.last_three_alphabetically
    order(name: :desc).first(3)
  end

  def self.without_a_captain
    where("captain_id IS NULL")
  end

  def self.sailboats
    all.select {|boat| boat.classifications.include?(Classification.find_by(name: 'Sailboat'))}
  end

  def self.sailboats_with_captain
    sailboats.reject { |sailboat| sailboat.captain.nil? }
  end

  def self.with_three_classifications
    all.select {|boat| boat.classifications.length == 3}
  end
end

