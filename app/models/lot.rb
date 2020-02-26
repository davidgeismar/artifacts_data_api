class Lot < ApplicationRecord
  validates_uniqueness_of :original_object_id, scope: [:sale]
  belongs_to :sale
  has_many :artists


  def self.build_valid_lot(lot, sale_id, sale_currency)
    lot_details = lot['lotDetails']
    estimates = lot['extra_details'] ? extract_estimates(lot['extra_details']['estimate'], sale_currency) : [nil, nil]
    now = Time.now
    {
      dump: lot,
      title1: lot_details['LotTitle']['Title1'],
      title2: lot_details['LotTitle']['Title2'],
      price_label: lot_details['Pricevalues']['PriceLabel'],
      primary_price: normalize_price(lot_details['Pricevalues']['PrimaryPrice'], sale_currency),
      secondary_price: normalize_price(lot_details['Pricevalues']['SecondaryPrice'], sale_currency),
      sale_id: sale_id,
      original_object_id: lot_details["ObjectID"],
      artist_id: extract_artist(lot_details['LotTitle']['Title1']),
      currency: sale_currency,
      low_estimate: estimates[0]&.to_i,
      high_estimate: estimates[1]&.to_i,
      created_at: now,
      updated_at: now,
    }
  end

  def self.extract_artist(title1)
    if /^([^(*]+).+?(\d+)-.*?(\d+)/.match(title1)
      artist, birth, death = /^([^*]+).+?([\d\\]+).*?-.*?([\d\\]+)?/.match(title1)[1..3]
      existing_artist = Artist.where(full_name: artist, birth_year: birth, death_year: death).first
      if existing_artist.present?
        existing_artist.id
      else
        artist = Artist.create(full_name: artist, birth_year: birth, death_year: death, original_title1: title1)
        artist.id
      end
    end
  end

  def self.normalize_price(price_string, sale_currency)
    price_string.tr("#{sale_currency},", '').to_i if price_string.present?
  end

  # "GBP 200" can be a single value
  def self.extract_estimates(estimate_range, sale_currency)
    if estimate_range.present?
      sanitaze_estimate = estimate_range.tr("#{sale_currency}, ", '')
      /(\d+)?[-]?(\d+)?/.match(sanitaze_estimate)[1..2]
    else
      [nil, nil]
    end
  end

  def get_google_vision_labels
    # need to figure out how to get a json from that and see what should be store
    image_annotator = Google::Cloud::Vision::ImageAnnotator.new
    file_name = "./resources/cat.jpg"
    response = image_annotator.label_detection image: file_name
    response.responses.each do |res|
      puts "Labels:"
      res.label_annotations.each do |label|
        puts label.description
      end
    end
  end
end
