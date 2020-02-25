class Christies::SalesController < ApplicationController
  SALE_ORGANIZER_ID = SaleOrganizer.find_by_company_name('Christies').id

  # handle response properly
  def create
    data = JSON.parse(params[:data])
    sale = data['sale']
    lots = data['lots']
    sale = Sale.create(Sale.build_valid_sale(sale, SALE_ORGANIZER_ID))
    valid_lots = lots.map {|lot| Lot.build_valid_lot(lot, sale.id, sale.currency)}
    Lot.insert_all(valid_lots)
  end
end
