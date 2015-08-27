class Song < ActiveRecord::Base
  has_many :song_genres
  has_many :genres, through: :song_genres
  belongs_to :artist

  def self.find_by_slug(slug)
    s = slug.gsub('-',' ')
    song = self.where('lower(name) = ?', s)[0]
  end

  def slug
    name.downcase.gsub(' ','-')
  end
end
