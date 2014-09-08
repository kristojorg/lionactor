require "spec_helper"

describe Lionactor::Location do
  context "with a circulating branch" do
    before :each do
      client = double(Lionactor::Client)
      data = JSON.parse(MML)["location"]
      @loc = Lionactor::Location.new(data, client)
    end

    describe "via automatic methods" do
      it "has an id" do
        expect(@loc.id).to eq "MML"
      end

      it "has a name" do
        expect(@loc.name).to eq "Mid-Manhattan Library"
      end

      it "has a slug" do
        expect(@loc.slug).to eq "mid-manhattan-library"
      end

      it "has an about statement" do
        expect(@loc.about).to start_with "Established in 1970"
      end

      it "is fully accessible" do
        expect(@loc.access).to eq "Fully Accessible"
      end

      it "has a street address" do
        expect(@loc.street_address).to eq "455 Fifth Avenue"
      end

      it "has a city" do
        expect(@loc.locality).to eq "New York"
      end

      it "has a state" do
        expect(@loc.region).to eq "NY"
      end

      describe "#postal code" do
        # This is currently a mistake in the API
        it "should be a string" do
          pending "the API returning postal codes as strings"
          expect(@loc.postal_code).to be_an_instance_of(String)
        end

        it "has a postal code" do
          pending "the API returning postal codes as strings"
          expect(@loc.postal_code).to eq "10016"
        end
      end

      it "has a cross street" do
        expect(@loc.cross_street).to eq "at 40th Street"
      end

      it "has a type" do
        expect(@loc.type).to eq "circulating"
      end      
    end

    describe "#amenities" do
      it "returns an hash" do
        expect(@loc.amenities).to be_an_instance_of Hash
      end

      it "returns a hash of Arrays" do
        expect(@loc.amenities.map{|a| a.class}.uniq).to eq [Array]
      end

      it "returns a hash of Arrays of Amenity objects" do
        expect(@loc.amenities['Computer Services'].map{|a| a.class}.uniq).to eq [Lionactor::Amenity]
      end
    end

    describe "#is_circulating?" do
      it "is true" do
        expect(@loc.is_circulating?).to be true
      end
    end

    describe "#is_research?" do
      it "is false" do
        expect(@loc.is_research?).to be false
      end
    end

    describe "#open?" do
      it "is true" do
        expect(@loc.open?).to be true
      end
    end

    describe "#latitude" do
      it "is a Float" do
        expect(@loc.latitude).to be_a Float
      end

      it "is 40.7518" do
        expect(@loc.latitude).to eq 40.7518
      end
    end

    describe "#longitude" do
      it "is a Float" do
        expect(@loc.longitude).to be_a Float
      end

      it "is -73.9817" do
        expect(@loc.longitude).to eq -73.9817
      end
    end
  end

  context "With a research branch" do
    before :each do
      client = double(Lionactor::Client)
      data = JSON.parse(SASB)["location"]
      @loc = Lionactor::Location.new(data, client)
    end

    describe "#is_circulating?" do
      it "is true" do
        expect(@loc.is_circulating?).to be false
      end
    end

    describe "#is_research?" do
      it "is false" do
        expect(@loc.is_research?).to be true
      end
    end
  end
    
end
 