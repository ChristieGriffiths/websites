# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end
  
  post '/albums' do
    repo = AlbumRepository.new
    
    album = Album.new
    album.title = params[:title]
    album.release_year = params[:release_year]
    album.artist_id = params[:artist_id]
    
    puts repo.create(album)
    "You have successfully added #{album.title} to the database."
  end
  
  
  # post "/artist" do
  #   repo  = ArtistRepository.new
  #   artist = Artist.new
  #   artist.name = params[:name]
  #   artist.genre = params[:genre]
  #   repo.create(artist)  
  # end
  
  get "/" do 
    return erb(:index)
  end 
  
  get "/albums/:id" do
    artist_repo = ArtistRepository.new 
    album = AlbumRepository.new
    @album = album.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)
    return erb(:album)
  end
  
  get '/artist/:id' do
    artist =  ArtistRepository.new
    @artist = artist.find(params[:id])
    p @artist 
    return erb(:artist)
  end

  get '/artist' do
    artist = ArtistRepository.new
    @artists = artist.all 
    return erb(:list_artists)
  end
  
  get '/albums' do
    albums = AlbumRepository.new 
    @albums = albums.all 
    return erb(:list_albums)
  end
  
end