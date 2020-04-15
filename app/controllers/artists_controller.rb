class ArtistsController < Sinatra::Base
  
 get '/artists/new' do 
  @artists = Artists.all
  erb :"artists/index"
 end 
 
 get "artists/:slug" do 
   slug = params[:slug]
   @artist = Artist.find_by_slug(slug)
   erb :"/artists/show"
 end 
 
end
