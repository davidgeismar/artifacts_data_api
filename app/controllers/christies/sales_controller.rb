class Christies::SalesController < ApplicationController
  @@sale_organizer = SaleOrganizer.find_by_company_name('Christies')

  def create
    data = JSON.parse(params[:data])
    sale = data['sale']
    lots = data['lots']
    sale = Sale.find_by_original_id(sale['sale_id']) || @@sale_organizer.sales.create(Sale.build_valid_sale(sale))
    valid_lots = lots.map {|lot| Lot.build_valid_lot(lot, sale.id, sale.currency)}
    Lot.insert_all(valid_lots)
  end
end
