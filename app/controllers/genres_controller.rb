class GenresController < Sinatra::Base
  
  get "/genres" do 
    @genres = Genres.all 
    erb :"genres/index"
  end 
  
  get "/genres/:slug" do 
    sug = params[:slug]
    @genre = find_by_slug(slug)
    erb :"genres/show"
  end 
end 



