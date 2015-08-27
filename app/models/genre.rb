class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  def self.find_by_slug(slug)
    s = slug.gsub('-',' ')
    genre = self.where('lower(name) = ?', s)[0]
  end

  def slug
    name.downcase.gsub(' ','-')
  end
end
