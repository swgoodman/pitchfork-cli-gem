
class PitchforkLatest::Review
  attr_accessor :url, :album, :artist, :genre, :score, :first_paragraph, :author
  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end
end
