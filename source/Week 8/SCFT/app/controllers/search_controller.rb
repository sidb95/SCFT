class SearchController < ApplicationController

	$found = 0
	$lat= ""
	$long = ""
	$ilatitude_range= 0
	$ielevation_range= 0
	$imax = 0
	$imin = 0
	$iradius_range= 0
	$icityname = " "
	$ilatitude_mycity = 0
	$ilongitude_mycity = 0
	$ielevation_mycity = 1000
	def getsearchdata

		#$icityname= params[:city]
#		$ilatitude_range= params[:latitude_range]
#		$ielevation_range= params[:elevation_range]
#		$iradius_range= params[:radius_range]

		#$ilatitude_range= params[:latitude_range]
		#$ielevation_range= params[:elevation_range]
		#$iradius_range= params[:radius_range]



		@mycity = Location.find_by(City: $icityname)

		#If the city does not exists in database 
		if @mycity == nil
	
			redirect_to :action => 'findSurrogateCity' ,:city => params[:city] ,:latitude_range => params[:latitude_range], :elevation_range => params[:elevation_range] ,:radius_range => params[:radius_range]
			
			#If the city  exist in database 
		else
			redirect_to :action => 'exists', :city => params[:city]

		end 

	end

	def findSurrogateCity

		if $found == 0
			$icityname= params[:city]
			$ilatitude_range= params[:latitude_range]
			$ielevation_range= params[:elevation_range]
			$iradius_range= params[:radius_range]


		#get data from JS code of geocoder
			

			@city = $icityname
			@lat_range = $ilatitude_range
			@rad_range = $iradius_range
	
		#set range
			@latitude_Range_Start = $ilatitude_mycity.to_f - $ilatitude_range.to_f
			@latitude_Range_End = $ilatitude_mycity.to_f + $ilatitude_range.to_f

		#@latresults = Location.where('Latitude > ? AND Latitude < ?',@latitude_Range_Start,@latitude_Range_End)

			@elevation_Range_Start = $elevation_mycity.to_f - $ielevation_range.to_f
			@elevation_Range_End = $elevation_mycity.to_f + $ielevation_range.to_f

			@results = Location.where('Latitude > ? AND Latitude < ? AND Elevation > ? AND Elevation < ?',@latitude_Range_Start,@latitude_Range_End,@elevation_Range_Start, @elevation_Range_End)

		else
		
			redirect_to :action => 'exists', :city => $icityname		

		end


	end

	def weather
		$icityname= params[:city]
		$ilatitude_range= params[:latitude_range]
		$ielevation_range= params[:elevation_range]
		$iradius_range= params[:radius_range]
		$ilatitude_mycity = params[:latitude_mycity]
		$ilongitude_mycity = params[:longitude_mycity]

		
	    @mycity = Location.find_by(City: $icityname)

		#If the city does not exists in database 
		if @mycity == nil
 	
		 	#redirect_to :action => 'weather' ,:city => params[:city] ,:latitude_range => params[:lat], :elevation_range => params[:altrange] ,:radius => params[:radrange]
			$found = 0
		#If the city  exist in database 
		
		else
			#redirect_to :action => 'exists', :city => params[:city]
			$found = 1

		end 
 


	end 

	def exists
		@ecity = Location.find_by(City: params[:city])
		@cityname = @ecity.City
		@citycountry = @ecity.Country
		@cityelev = @ecity.Elevation

		

	end

end
			
			
