class EventsController < ApplicationController
	def index
		@output = params

		#used for database population
		#csvimport
	end

	def bydate
		@output = params
	end

	def csvimport
		puts "Imported CSV File to database."
	end

	private
		def event_params
			params.require(:event).permit(:start, :finish, :name, :track)
		end
end
