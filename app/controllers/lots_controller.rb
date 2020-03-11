class LotsController < ApplicationController
  def show
    lot = Lot.find(params[:id])
    all_lot_sales = Lot.where(original_object_id: lot.original_object_id)
    total = all_lot_sales.pluck(:primary_price).reduce(:+)
    render json: {lot: lot, sales: format_lot_data(all_lot_sales), total: total, sales_count: all_lot_sales.count, performance: compute_object_performance(all_lot_sales) }
  end

  private

  def compute_object_performance(all_lot_sales)
    all_lot_sales.reduce(0) {|sum, lot| sum + (lot.primary_price.to_f / lot.low_estimate.to_f) + (lot.primary_price.to_f / lot.high_estimate.to_f)}
  end

  def format_lot_data(lots)
    lots.map{ |lot| {id: lot.id, primaryPrice: lot.primary_price, high_estimate: lot.high_estimate, low_estimate: lot.low_estimate, saleDate: lot.dump["lotDetails"]["SaleDate"], lotName: lot.dump["lotDetails"]["LotTitle"]["Title2"] }}
  end
end
