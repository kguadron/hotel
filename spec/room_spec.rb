require "pry"
require "date"
require_relative "spec_helper"

describe "Room class" do
  describe "initialize" do
    before do
      @room = HotelSystem::Room.new(1)
    end

    it "is an instance of a room" do
      expect(@room).must_be_kind_of HotelSystem::Room
    end
  end

  describe "date_overlap method" do
    before do
      @room = HotelSystem::Room.new(1)
      @reservation = HotelSystem::Reservation.new(room: @room,
                                                 start_date: Date.new(2019, 3, 11),
                                                 end_date: Date.new(2019, 3, 14),
                                                 guest: "Sam")
      @room.reservations << @reservation
    end

    it "returns false if the chosen start date matches the start date of the reservation" do
      expect(@room.date_overlap?(Date.new(2019, 3, 11), Date.new(2019, 3, 12))).must_equal false
    end

    it "returns false if the chosen start date falls between the reservations start date and end date" do
      expect(@room.date_overlap?(Date.new(2019, 3, 13), Date.new(2019, 3, 15))).must_equal false
    end

    it "returns false if the chosen end date falls between the reservations start date and end date" do
      expect(@room.date_overlap?(Date.new(2019, 3, 10), Date.new(2019, 3, 12))).must_equal false
    end

    it "returns true if the chosen start date is after the reservations end date" do
      expect(@room.date_overlap?(Date.new(2019, 3, 15), Date.new(2019, 3, 17))).must_equal true
    end

    it "returns true if the chosen start date is on the same day as the reservations end date" do
      expect(@room.date_overlap?(Date.new(2019, 3, 14), Date.new(2019, 3, 15))).must_equal true
    end

    it "returns true if the chosen end date matches the start date of the reservation" do
      expect(@room.date_overlap?(Date.new(2019, 3, 10), Date.new(2019, 3, 11))).must_equal true
    end
  end
end