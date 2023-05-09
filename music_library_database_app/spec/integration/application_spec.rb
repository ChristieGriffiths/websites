require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  def reset_albums_table
    seed_sql = File.read('spec/seeds/albums_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_albums_table
  end

  # context "/albums" do
  #   it "returns a list of albums" do
  #     list_of_albums = "Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring"
  #     response = get("/albums")
  #     expect(response.body).to eq (list_of_albums)
  #   end

  #   it 'Should add a new album object to the database' do
  #     response = post("/albums", title: "Voyage", release_year: "2022", artist_id: "2")

  #     expect(response.status).to eq(200)
  #     expect(response.body).to eq "You have successfully added Voyage to the database."
  #   end

  #   it 'Should add a new album object to the database' do
  #     response = post("/albums", title: "Born to Run", release_year: "1976", artist_id: "1")
  #     list_of_albums = "Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring, Born to Run"
  #     response_2 = get("/albums")
  #     expect(response.status).to eq(200)
  #     expect(response.body).to eq "You have successfully added Born to Run to the database."
  #     expect(response_2.body).to eq (list_of_albums)
  #   end
  # end

  context "/artist" do
    it "returns a web page with listed artists" do
      response = get("/artist/4")
      expect(response.status).to eq (200)
      expect(response.body).to include ("Nina Simone")
      expect(response.body).to include ("Pop")

    it "returns a list of arists with option to click to see more info" do
      response = get("/artist")
      expect(response.status).to eq (200)
      expect(response.body).to include ("Nina Simone")
      expect(response.body).to include ("Pixies")
      expect(response.body).to include ("ABBA")
    end
  end 

    # it "posts a new artist to the list" do 
    #   response = post("/artist", name: "Wild nothing", genre: "indie")
    #   response_2 = get("/artist")
    #   list_of_artists = "Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos, Wild nothing"
    #   expect(response.status).to eq (200)
    #   expect(response_2.status).to eq (200)
    #   expect(response_2.body).to eq (list_of_artists)
    # end 
  end

  context "GET with html" do
    it "contains a h1 title" do
      response = get("/")
      expect(response.body).to include ("Hello!</h1>") 
    end
  end 

  context "finds an album" do 
    it "and returns the info" do
      response = get("/albums/1")  
      expect(response.status).to eq (200)
      expect(response.body).to include ("Doolittle")
      expect(response.body).to include ("1989")
    end
  end

  context "get all albums" do 
   it "and returns them in html format" do
      response = get("/albums")  

      expect(response.status).to eq (200)
      expect(response.body).to include('<a href="/albums/2"')
      expect(response.body).to include('Surfer Rosa')

    end
  end 
end
