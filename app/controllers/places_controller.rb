class PlacesController < ApplicationController

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
     @place = Place.new
     @place.name = params[:place][:name]
     @place.link = params[:place][:link]
     @place.description = params[:place][:description]

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

     @place.name = params[:place][:name]
     @place.link = params[:place][:link]
     @place.description = params[:place][:description]

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


end
