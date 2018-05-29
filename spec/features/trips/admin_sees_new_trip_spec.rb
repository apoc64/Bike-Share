require 'rails_helper'

describe "An admin" do
  context "visits the admin new trip page" do
    it "and sees a form to add a new trip" do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)
    station = Station.create(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
    duration = 100
    start_date = Time.now
    start_station = station.id
    end_date = (Time.now + 1)
    end_station = station.id
    bike_id = 4
    subscription_type = 'Member'
    zip_code = 80202

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_trip_path

    save_and_open_page
    fill_in 'trip[duration]',	with: duration
    fill_in 'trip[start_date]',	with: start_date
    fill_in 'trip[start_station_id]',	with: station
    fill_in 'trip[end_date]',	with: end_date
    fill_in 'trip[end_station_id]',	with: station.name
    fill_in 'trip[bike_id]',	with: bike_id
    fill_in 'trip[subscription_type]',	with: subscription_type
    fill_in 'trip[zip_code]',	with: zip_code

    click_on 'Create Trip'
    
    expect(current_page).to eq(admin_trip)
    expect(current_page).to have_content(trip.duration)
    expect(current_page).to have_content(trip.start_date)
    expect(current_page).to have_content(station.name)
    expect(current_page).to have_content(trip.end_date)
    expect(current_page).to have_content(station.name)
    expect(current_page).to have_content(trip.bike_id)
    expect(current_page).to have_content(trip.subscription_type)
    expect(current_page).to have_content(trip.zip_code)
    end
  end
end
