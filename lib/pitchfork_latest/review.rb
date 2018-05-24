
class PitchforkLatest::Review
  attr_accessor :url, :album, :artist, :genre, :rating, :first_paragraph
  @@all = []

  def initialize
    @@all << self
  end

  def self.scrape_latest

    doc = Nokogiri::HTML(open("https://pitchfork.com/"))

    doc.search("div.album-review-hero").each do |review|
      review = self.new
      review.url = doc.search("div.album-details a").attribute("href").text
      review.album = doc.search("ul.artist-list").text
      review.artist = doc.search("h2.title").text
      review.genre = doc.search("ul.genre-list").text
    end
  end
end
