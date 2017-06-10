class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :restaurants_chicago, :restaurants_atlanta, :restaurants_new_orleans, :restaurants_seattle, :restaurants_tampa, :restaurants_tucson]
  before_action :authenticate_admin!, only: [:destroy]

  # GET /restaurants
  # GET /restaurants.json

  def city_search
    if params[:city_search].present?
        @restaurants = Restaurant.search(params[:city_search])
    else
        @restaurants = Restaurant.all
    end
  end
  
#added from restaurants helper, not sure where this should go or how to get the link to restaurant to open in another window. 
  def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end

  def index
    #restaurants = Restaurant.near([@geocoder_result.latitude, @geocoder_result.longitude], 50)

   
    # # elsif @userLocation #some code to check
    # #   # @restaurants = Restaurant.near(@userLocation, 15)
    # #   @restaurants = Restaurant.all.sort_by { |r| Geocoder::Calculations.distance_between(@userLocation, [r.latitude, r.longitude]) }
    # else

    #if params[:location].present?
      #@restaurants = Restaurant.near(params[:location], params[:distance] || 10, order: :distance)
     #else
    #@desired_location = params[:search](trying to make flash error if box is left blank)

    #@user_location = location #gets the location of the user ip
    #@search_results = Geocoder.seach(search_locations)
    #[current_user.latitude, current_user.longitude]

    if params[:search].present?
     @restaurants = Restaurant.near(params[:search], 15)
    # elsif location.present?
    # @restaurants = Restaurant.near([location.latitude, location.longitude], 100)
    elsif params[:restaurants_near_chicago]
      @restaurants = Restaurant.near('Chicago, IL', 40)
    elsif params[:restaurants_near_tucson]
      @restaurants = Restaurant.near("Tucson, AZ")
    elsif params[:restaurants_near_atlanta]
      @restaurants = Restaurant.near("Atlanta, GA")
    elsif params[:restaurants_near_seattle]
      @restaurants = Restaurant.near("Seattle, WA")
    elsif params[:restaurants_near_new_orleans]
      @restaurants = Restaurant.near("New Orleans, LA")
    elsif params[:restaurants_near_tampa]
      @restaurants = Restaurant.near("Tampa, FL")
    elsif params[:restaurants_near_indianapolis]
      @restaurants = Restaurant.near("Indianapolis, IN", 120)
    elsif params[:restaurants_near_birmingham]
      @restaurants = Restaurant.near("Birmingham, AL", 120)
    elsif params[:restaurants_near_austin]
      @restaurants = Restaurant.near("Austin, TX")
    elsif params[:restaurants_near_phoenix]
      @restaurants = Restaurant.near("Phoenix, TX")
    else
     @restaurants = Restaurant.all.order('name ASC')
    end

    @arrayOfRestaurants = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      restaurant_path = view_context.link_to restaurant.name, restaurant_path(restaurant)
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.infowindow "<b>#{restaurant_path}</b>" + "<br>" + restaurant.address + "<br>" + "<a href='" + url_with_protocol(restaurant.url) + "'target='_blank'>" + restaurant.url + "</a>"
    end  
  end

  def restaurants_chicago
    if params[:search].present?
     @restaurants = Restaurant.near(params[:search], 15)
    else
     @restaurants = Restaurant.all.order('name ASC')
    end

    @arrayOfRestaurants = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      restaurant_path = view_context.link_to restaurant.name, restaurant_path(restaurant)
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.infowindow "<b>#{restaurant_path}</b>" + "<br>" + restaurant.address + "<br>" + "<a href='" + url_with_protocol(restaurant.url) + "'target='_blank'>" + restaurant.url + "</a>"
    end  
  end

  def restaurants_atlanta
    if params[:search].present?
     @restaurants = Restaurant.near(params[:search], 15)
    else
     @restaurants = Restaurant.all.order('name ASC')
    end

    @arrayOfRestaurants = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      restaurant_path = view_context.link_to restaurant.name, restaurant_path(restaurant)
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.infowindow "<b>#{restaurant_path}</b>" + "<br>" + restaurant.address + "<br>" + "<a href='" + url_with_protocol(restaurant.url) + "'target='_blank'>" + restaurant.url + "</a>"
    end  
  end

  def restaurants_new_orleans
    if params[:search].present?
     @restaurants = Restaurant.near(params[:search], 15)
    else
     @restaurants = Restaurant.all.order('name ASC')
    end

    @arrayOfRestaurants = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      restaurant_path = view_context.link_to restaurant.name, restaurant_path(restaurant)
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.infowindow "<b>#{restaurant_path}</b>" + "<br>" + restaurant.address + "<br>" + "<a href='" + url_with_protocol(restaurant.url) + "'target='_blank'>" + restaurant.url + "</a>"
    end  
  end

  def restaurants_tucson
    if params[:search].present?
     @restaurants = Restaurant.near(params[:search], 15)
    else
     @restaurants = Restaurant.all.order('name ASC')
    end

    @arrayOfRestaurants = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      restaurant_path = view_context.link_to restaurant.name, restaurant_path(restaurant)
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.infowindow "<b>#{restaurant_path}</b>" + "<br>" + restaurant.address + "<br>" + "<a href='" + url_with_protocol(restaurant.url) + "'target='_blank'>" + restaurant.url + "</a>"
    end  
  end

  def restaurants_seattle
    if params[:search].present?
     @restaurants = Restaurant.near(params[:search], 15)
    else
     @restaurants = Restaurant.all.order('name ASC')
    end

    @arrayOfRestaurants = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      restaurant_path = view_context.link_to restaurant.name, restaurant_path(restaurant)
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.infowindow "<b>#{restaurant_path}</b>" + "<br>" + restaurant.address + "<br>" + "<a href='" + url_with_protocol(restaurant.url) + "'target='_blank'>" + restaurant.url + "</a>"
    end  
  end

  def restaurants_tampa
    if params[:search].present?
     @restaurants = Restaurant.near(params[:search], 15)
    else
     @restaurants = Restaurant.all.order('name ASC')
    end

    @arrayOfRestaurants = Gmaps4rails.build_markers(@restaurants) do |restaurant, marker|
      restaurant_path = view_context.link_to restaurant.name, restaurant_path(restaurant)
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      marker.infowindow "<b>#{restaurant_path}</b>" + "<br>" + restaurant.address + "<br>" + "<a href='" + url_with_protocol(restaurant.url) + "'target='_blank'>" + restaurant.url + "</a>"
    end  
  end
  # def search
  #   if params[:search].present?
  #       @restaurants = Restaurant.search(params[:search])
  #   else
  #       @restaurants = Restaurant.all.order('name ASC')
  #   end
  # end

  def restaurant_list
    if params[:search].present?
     @restaurants = Restaurant.near(params[:search], 15)
    elsif location.present?
     @restaurants = Restaurant.near([location.latitude, location.longitude], 2500)
    else
     @restaurants = Restaurant.all.order('name ASC')
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  @restaurant = Restaurant.find(params[:id])
    @hash = Gmaps4rails.build_markers(@restaurant) do |restaurant, marker|
      marker.lat restaurant.latitude
      marker.lng restaurant.longitude
      #                 <a href="/restaurants/7">  </a>
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