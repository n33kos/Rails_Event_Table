class EventsController < ApplicationController
	def index
		@events = Event.all
		@dates =  Event.unique_dates
		@tracks = Event.uniq.pluck(:track)
		
		if !params[:sort].blank?
			if params[:sort] == "alpha"
				@tracks = @tracks.sort{|a,b| a<=>b}
			else
				@tracks = @tracks.sort{|a,b| b<=>a}
			end
		end

		@global_events = [
			"Monday Plenary Session 1",
			"Coffee Break",
			"Lunch",
			"Poster Session MoBT8",
			"A night at the acquarium",
		]
		@excluded_tracks = [
			"Keynote",
			"Coffee Breaks",
			"Party",
		]
		#csvimport #used for database population
	end

	def bydate
		@events = Event.by_date({:date => params[:date], :sort => params[:sort]})
		@dates =  Event.unique_dates
		@tracks = Event.uniq.pluck(:track)
		
		if !params[:sort].blank?
			if params[:sort] == "alpha"
				@tracks = @tracks.sort{|a,b| a<=>b}
			else
				@tracks = @tracks.sort{|a,b| b<=>a}
			end
		end

		@global_events = [
			"Monday Plenary Session 1",
			"Coffee Break",
			"Lunch",
			"Poster Session MoBT8",
			"A night at the acquarium",
		]
		@excluded_tracks = [
			"Keynote",
			"Coffee Breaks",
			"Party",
		]
	end

	def csvimport
		require 'csv'
		CSV.foreach('test_events.csv', :headers => true) do |row|
			Event.create!(row.to_hash)
		end
		puts "Imported CSV File to database."
	end

	def create
		@event = Event.new(event_params)
		@event.save
	end

	private
		def event_params
			params.require(:event).permit(:start, :finish, :name, :track)
		end
end
