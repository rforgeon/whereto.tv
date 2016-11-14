class PlacesController < ApplicationController

  helper_method :get_link_info
  helper_method :topPlaceVideos
  helper_method :strip_link_id

  before_action :require_sign_in, except: [:index, :show]


  def index
    @places = Place.all
  end

  def show
    @place = Place.find(params[:id])
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)

     if @place.save
       redirect_to @place, notice: "Place was saved successfully."
     else
       flash.now[:alert] = "Error creating place. Please try again."
       render :new
     end
   end

   def edit
     @place = Place.find(params[:id])
   end

   def update
     @place = Place.find(params[:id])

     @place.assign_attributes(place_params)

     if @place.save
        flash[:notice] = "Place was updated."
       redirect_to @place
     else
       flash.now[:alert] = "Error saving place. Please try again."
       render :edit
     end
   end

   def destroy
     @place = Place.find(params[:id])

     if @place.destroy
       flash[:notice] = "\"#{@place.name}\" was deleted successfully."
       redirect_to action: :index
     else
       flash.now[:alert] = "There was an error deleting the place."
       render :show
     end
   end

   def get_link_info(link)
    link_obj = LinkThumbnailer.generate(link)
    return link_obj
  end

  def strip_link_id(link)
    link.reverse!
    if link.include? '='
      codeArray = link.split('=',2)
    else
      codeArray = link.split('/',2)
    end
    code = codeArray[0]
    code.reverse!
    return code
  end

  def topPlaceVideos
    @place = Place.find(params[:id])
    videoRankArray = []
    @place.posts.each do |post|
      linkCode = strip_link_id(post.link)
      videoRankArray.push([post.rank,linkCode])
    end
    videoRankArray.sort!{|x,y|y<=>x}
    videoCodeString = ''
    videoRankArray.each_with_index do |video,vid_index|
      if vid_index < 5
        videoCodeString = videoCodeString+video[1]+','
      else
        return videoCodeString
      end
    end
    return videoCodeString
  end

   private

   def place_params
     params.require(:place).permit(:name, :link, :description)
   end

end
