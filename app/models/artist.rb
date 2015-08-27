class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def self.find_by_slug(slug)
    s = slug.gsub('-',' ')
    artist = self.where('lower(name) = ?', s)[0]
  end

  def slug
    name.downcase.gsub(' ','-')
  end
end
