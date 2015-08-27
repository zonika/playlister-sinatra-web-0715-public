class SongController < ApplicationController
  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end
  get '/songs/new' do
    @genres = Genre.all
    erb :'songs/new'
  end
  post '/songs/new' do
    artist = Artist.where(name: params[:song][:artist])
    if artist == []
      a = Artist.create(name: params[:song][:artist])
    else
      a = artist.first
    end
    genre = Genre.where(name: params[:genre])
    @song = Song.create(name: params[:song][:name], artist: a)
    SongGenre.create(song_id: @song.id, genre_id: genre[0].id)
    @song.save
    erb :'songs/new-success'
  end
  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    erb :'songs/edit'
  end
  patch '/songs/:slug/edit' do
    artist = Artist.where(name: params[:song][:artist])
    if artist == []
      a = Artist.create(name: params[:song][:artist])
    else
      a = artist.first
    end
    @song = Song.find_by_slug(params[:slug])
    if params[:genre] == nil
      genre = @song.genres[0]
    else
      genre = Genre.where(name: params[:genre])[0]
    end
    @song.update(name: params[:song][:name], artist: a)
    sg = SongGenre.where(song_id: @song.id)[0]
    sg.update(song_id: @song.id, genre_id: genre.id)
    @song.save
    erb :'songs/edit-success'
  end
  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end
end
