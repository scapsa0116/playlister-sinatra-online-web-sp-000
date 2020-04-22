require 'rack-flash'
class  SongsController < ApplicationController
  use Rack::Flash
  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end
 
  get '/songs/new' do
    @genres = Genre.all
    erb :'/songs/new'
  end
 
  get "/songs/:slug" do
    #binding.pry
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/show"
  end
 
  post '/songs' do
    @song = Song.create(:name => params[:Name])

    artist_entry = params["Artist Name"]
    if Artist.find_by(:name => artist_entry)
      artist = Artist.find_by(:name => artist_entry)
    else
      artist = Artist.create(:name => artist_entry)
    end
    @song.artist = artist
   #binding.pry
    genre_selections = (params[:genres]) || []
   
    genre_selections.each do |genre|
    
      @song.genres << Genre.find(genre)
    end
    
    @song.save
    #binding.pry
    flash[:message] = "Successfully created song."
    redirect  "/songs/#{@song.slug}"
  end
 
  get "/songs/:slug/edit" do
    @song = Song.find_by_slug(params[:slug])
    @artist = @song.artist
    @genres = Genre.all
    erb :'/songs/edit'
  end
 
  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    #binding.pry
    @song.update(params[:song])
    # genre_selections = (params[:genres])
    @song.genre_ids = params[:song][:genre_ids]
    #binding.pry
    @song.artist = Artist.find_or_create_by(name: params["Artist Name"])
    #binding.pry
    @song.save
    flash[:message] = "Successfully updated song."
    redirect  "/songs/#{@song.slug}"
  end
 end


