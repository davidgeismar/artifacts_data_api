class Christies::LotsController < ApplicationController
  @@sale_organizer = SaleOrganizer.find_by_company_name('Christies')

  def create
    lot = JSON.parse(params[:data])
    sale = Sale.find_by_original_id(lot['lotDetails']['SaleID'])
    Lot.create(Lot.build_valid_lot(lot, sale.id, sale.currency))
  end
end
