class TripsController < ApplicationController

  def index
    @trips = Trip.paginate(page: params[:page])
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def dashboard
    @average = Trip.average(:duration)
    @longest = Trip.where(duration: Trip.maximum(:duration)).first.id
    @shortest = Trip.where(duration: Trip.minimum(:duration)).first.id
    @most_starts = Trip.select('COUNT(id) AS trip_count, start_station_id').group(:start_station_id).order('trip_count DESC').first.start_station
    @fewest_starts = Trip.select('COUNT(id) AS trip_count, end_station_id').group(:end_station_id).order('trip_count DESC').first.end_station

    bikes = Trip.select('COUNT(id) AS bike_count, bike_id').group(:bike_id).order('bike_count DESC')
    @most_ridden_bike = bikes.first.bike_id
    @most_bike_rides = bikes.first.bike_count
    @least_ridden_bike = bikes.last.bike_id
    @fewest_bike_rides = bikes.last.bike_count

    subscriptions = Trip.select('COUNT(id) AS sub_count, subscription_type').group(:subscription_type).order('sub_count DESC')
    # binding.pry
    total_count = Trip.count
    @subscriber_count = subscriptions.where(subscription_type: 'Subscriber').first.sub_count
    @subscriber_percent = (@subscriber_count * 100) / total_count
    @customer_count = subscriptions.where(subscription_type: 'Customer').first.sub_count
    @customer_percent = (@customer_count * 100) / total_count
  end
end
