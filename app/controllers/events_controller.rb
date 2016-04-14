class EventsController < ApplicationController
	def index
		@events = Event.all
		#csvimport #used for database population
	end

	def bydate
		@events = Event.bydate({:date => params[:date], :sortby => params[:sort]})
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
