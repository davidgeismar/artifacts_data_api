class ArtistsController < ApplicationController
  def index
    artists = Artist.where('full_name ILIKE ?', "%#{params[:filter]}%")
    render json: artists
  end

  def string_artist
    render json:  Artist.all.first(100)
  end

end
