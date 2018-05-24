
class PitchforkLatest::Review
  attr_accessor :url, :album, :artist, :genre, :score, :first_paragraph
  @@all = []

  def initialize
    @@all << self
  end

  def self.scrape_latest

    doc = Nokogiri::HTML(open("https://pitchfork.com/"))

    review_blocks = []
    doc.search("div.album-review-hero")[1..4].each do |review|
      review_blocks << review
    end

    review_blocks.each.with_index do |review, i|
      review = self.new
      review.url = doc.search('a.album-link')[i].attribute('href').value
      review.artist = doc.search("ul.artist-list")[i].text.gsub(/[^a-zA-Z 0-9]/, "").gsub(/\s+/, ' ')

      review.album = doc.search("h2.title")[i+2].text.gsub(/[^a-zA-Z 0-9]/, "").gsub(/\s+/, ' ')
      review.genre = doc.search("ul.genre-list")[i].text
    end
    @@all
  end

  def scrape_info(url)
    doc = Nokogiri::HTML(open(self.url))

    self.score =


  end
end
