class UsersController < ApplicationController

  # GET /users.json
  def index
    @users = User.all

    render :json => @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
   # raise params.to_yaml
    @user = User.find_by_user_facebook_uid(params[:user_facebook_uid])
    render :json => @user
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    render :json => @user
  end

  # POST /users
  # POST /users.json
  def create
    #raise params.to_yaml
    @user = User.new(params[:user])

    if @user.save
      render :json => @user, :status => :created
    else
      render :json => {:errors => @user.errors, :status =>:unprocessable_entity}
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      head :no_content
    else
      render :json => @user.errors, :status => :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    head :no_content
  end


  def  say_hi

    name = params[:name]
    render :json => {:status => "ok", :msg => "Hello #{name}"}
  end


  def near_by
    current_user = User.find_by_user_facebook_uid(params[:uid])
    min_distance = params[:min].to_i
    max_distance = params[:max].to_i
    near_users = []
    unless current_user.nil?
      users = User.all
      users.each do |user|
        distance = lat_lon_to_distance(current_user.current_latitude,current_user.current_longitude,user.current_latitude,user.current_longitude)
        if distance >= min_distance and distance <= max_distance and user.user_facebook_uid != current_user.user_facebook_uid
          near_users << {
            :user_facebook_uid => user.user_facebook_uid,
            :user_name => user.fullname,
            :updated_at => user.updated_at
            }
        end
      end
    end
    render :json => near_users
  end


  private
  def lat_lon_to_distance(lat1,lon1,lat2,lon2)
    r = 6373; # km  ,3961 miles
    d_lat = (lat2-lat1) * Math::PI / 180
    d_lon = (lon2-lon1) * Math::PI / 180
    lat1 = lat1 * Math::PI / 180
    lat2 = lat2 * Math::PI / 180

    a = Math.sin(d_lat/2) * Math.sin(d_lat/2) + Math.sin(d_lon/2) * Math.sin(d_lon/2) * Math.cos(lat1) * Math.cos(lat2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    d = r * c
  end


end
