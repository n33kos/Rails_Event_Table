class Event < ActiveRecord::Base
	def self.unique_dates
		unique_dates = Event.uniq.pluck(:start)
		parsed_dates = []
		unique_dates.each do |date|
			parsed_dates.push(Date.parse(date.to_s))
		end
		return parsed_dates.uniq
	end

	def self.by_date(options = {})
		limit_date = Date.parse(options[:date])
		results = Event.where(:start => limit_date.beginning_of_day..limit_date.end_of_day)
		return results
	end

end