class Sale < ApplicationRecord
  validates_uniqueness_of :original_id, scope: [:sale_organizer]

  belongs_to :sale_organizer
  has_many :lots
  has_many :artists, through: :lots



  def self.build_valid_sale(sale, sale_organizer_id)
    begin
      {
        dump: sale,
        title: sale['title'],
        original_id: sale['sale_id'],
        location: sale['location'],
        currency: sale['sale_currency'],
        start_date: Date.parse(sale['sale_start_date']),
        end_date: Date.parse(sale['sale_end_date']),
        total: total(sale),
        sale_organizer_id: sale_organizer_id,
      }
    rescue StandardError => e
      binding.pry
    end
  end

  def self.total(sale)
    sale['sale_total_with_currency'].tr("#{sale['sale_currency']},", '').to_i
  end
end
