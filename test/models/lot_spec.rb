
require 'pry-byebug'
RSpec.describe 'Lot', type: :model do
  describe '.extract_artist' do
    before do
      @artist_regex = /^([^*]+).*?\(.*?(\d+)-.*?(\d+)\)/
    end

    it 'handles Theobald Michau* (1676-1765)' do
      title1 = 'Theobald Michau* (1676-1765)'
      artist, birth, death =  @artist_regex.match(title1)[1..3]
      expect(artist.strip).to eq("Theobald Michau")
      expect(birth.strip).to eq("1676")
      expect(death.strip).to eq("1765")
    end

    it 'Andrea Mainardi, il Chiaveghino* (c.1573-1629)' do
      title1 = 'Andrea Mainardi, il Chiaveghino* (c.1573-1629)'
      artist, birth, death = @artist_regex.match(title1)[1..3]
      expect(artist.strip).to eq("Andrea Mainardi, il Chiaveghino")
      expect(birth.strip).to eq("1573")
      expect(death.strip).to eq("1629")
    end

    it 'Pieter Verelst* (c.1618-after 1668)' do
      title1 = 'Pieter Verelst* (c.1618-after 1668)'
      artist, birth, death = @artist_regex.match(title1)[1..3]
      expect(artist.strip).to eq("Pieter Verelst")
      expect(birth.strip).to eq("1618")
      expect(death.strip).to eq("1668")
    end

    it 'Rodolf Banet (1901-1993)' do
      title1 = 'Rodolf Banet (1901-1993)'
      artist, birth, death =  @artist_regex.match(title1)[1..3]
      expect(artist.strip).to eq("Rodolf Banet")
      expect(birth.strip).to eq("1901")
      expect(death.strip).to eq("1993")
    end

    it 'Attributed to Edgar Bundy (1862-1922)' do
      title1 = 'Attributed to Edgar Bundy (1862-1922)'
      artist, birth, death =  @artist_regex.match(title1)[1..3]
      expect(artist.strip).to eq("Attributed to Edgar Bundy")
      expect(birth.strip).to eq("1862")
      expect(death.strip).to eq("1922")
    end

    it 'Circle of Giovanni Camillo Sagrestani (1660-1731)' do
      title1 = 'Circle of Giovanni Camillo Sagrestani (1660-1731)'
      artist, birth, death =  @artist_regex.match(title1)[1..3]
      expect(artist.strip).to eq("Circle of Giovanni Camillo Sagrestani")
      expect(birth.strip).to eq("1660")
      expect(death.strip).to eq("1731")
    end

    it 'LARS THORSEN (AMERICAN, 1876-1952)' do
      title1 = 'LARS THORSEN (AMERICAN, 1876-1952)'
      artist, birth, death =  @artist_regex.match(title1)[1..3]
      expect(artist.strip).to eq("LARS THORSEN")
      expect(birth.strip).to eq("1876")
      expect(death.strip).to eq("1952")
    end

    it 'Arco 35-I no. 151916' do
      title1 = 'Arco 35-I no. 151916'
      artist, birth, death =  @artist_regex.match(title1)[1..3]
      expect(artist.strip).to eq(nil)
      expect(birth.strip).to eq(nil)
      expect(death.strip).to eq(nil)
    end

    it 'A RARE 20-BORE (2½IN) SINGLE-TRIGGER D. B. HAMMERLESS SIDELO...' do
      title1 = 'A RARE 20-BORE (2½IN) SINGLE-TRIGGER D. B. HAMMERLESS SIDELO...'
      artist, birth, death = @artist_regex.match(title1)[1..3]
      expect(artist.strip).to eq(nil)
      expect(birth.strip).to eq(nil)
      expect(death.strip).to eq(nil)
    end
  end
end
