RSpec.describe Lot, type: :model do
  describe '.extract_artist' do
    Lot.extract_artist(title1)
    expect(depot.inventories.find_by(offer: offer1)).to_not be_nil
  end

end
