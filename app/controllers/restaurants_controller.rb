class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_admin!, only: [:destroy]

  # GET /restaurants
  # GET /restaurants.json
  
#added from restaurants helper, not sure where this should go or how to get the link to restaurant to open in another window. 
  def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end

  def index
    #@geocoder_result = request.location #gets the ip of the user
   
    #@restaurants = Restaurant.near([@geocoder_result.latitude, @geocoder_result.longitude], 50)

    # if params[:search].present?
    #    # @restaurants = Restaurant.near(params[:search], 15)
    # # elsif @userLocation #some code to check
    # #   # @restaurants = Restaurant.near(@userLocation, 15)
    # #   @restaurants = Restaurant.all.sort_by { |r| Geocoder::Calculations.distance_between(@userLocation, [r.latitude, r.longitude]) }
    # else
  @restaurants = Restaurant.all.order('name ASC')
    # end

    @arrayOfRestaurants = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.infowindow restaurant.name + "<br>" + restaurant.address + "<br>" + "<a href='" + url_with_protocol(restaurant.url) + "'target='_blank'>" + restaurant.url + "</a>"
    end   
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  @restaurant = Restaurant.find(params[:id])
    @hash = Gmaps4rails.build_markers(@restaurant) do |restaurant, marker|
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.infowindow restaurant.name + "<br>" + restaurant.address + "<br>" + "<a href='" + url_with_protocol(restaurant.url) + "'target='_blank'>" + restaurant.url + "</a>"
    end    
    
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :latitude, :longitude, :url, :menu)
    end
end
