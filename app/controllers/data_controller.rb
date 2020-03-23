class DataController < ApplicationController

  def artist_data
    artist = Artist.find(params[:id])
    lots = artist.lots.map{ |lot| {id: lot.id, primaryPrice: lot.primary_price, high_estimate: lot.high_estimate, low_estimate: lot.low_estimate, saleDate: lot.dump["lotDetails"]["SaleDate"], lotName: lot.dump["lotDetails"]["LotTitle"]["Title2"] }}
    max = [lots.pluck(:primaryPrice).max, lots.pluck(:high_estimate).max].max
    grouped_by_sale_date = lots.group_by{|lot| lot[:saleDate]}
    violon_plot_data = lots.map{|lot| [lot[:low_estimate], lot[:primaryPrice], lot[:high_estimate]]}
    lots_grouped_by_sale = artist.lots.group_by(&:sale)
    # for each sale array of lots
    box_prices_realized = []
    box_high_estimates = []
    box_low_estimates = []
    lots_grouped_by_sale.each do |sale_id, lots|
      box_prices_realized << lots.pluck(:primary_price)
      box_high_estimates  << lots.pluck(:high_estimate)
      box_low_estimates  << lots.pluck(:low_estimate)
    end
    line_prices_realized = lots.map { |lot| {x: Date.parse(lot[:saleDate]), y: lot[:primaryPrice]}}
    line_high_estimates = lots.map { |lot| {x: Date.parse(lot[:saleDate]), y: lot[:high_estimate]}}
    line_low_estimates = lots.map { |lot| {x: Date.parse(lot[:saleDate]), y: lot[:low_estimate]}}

    performance = artist.lots
    # currencies

    data = {
      salesNumber: artist.lots.pluck(:sale_id).uniq.count,
      totalSalesAmount: artist.lots.pluck(:primary_price).reduce(:+),
      performance: compute_artist_performance(artist.lots),
      artistName: artist.full_name,
      lots: lots,
      linePlot: {
        prices_realized: line_prices_realized,
        high_estimates: line_high_estimates,
        low_estimates: line_low_estimates
      },
      boxPlot: {
        prices_realized: box_prices_realized,
        high_estimates: box_high_estimates,
        low_estimates: box_low_estimates
      },
      violonPlot: violon_plot_data,
      grouped_by_sale_date: grouped_by_sale_date,
      max: max
    }
    render json: data
  end


  def compute_artist_performance(artist_lots)
    artist_lots.reduce(0) {|sum, lot| sum + (lot.primary_price.to_f / lot.low_estimate.to_f) + (lot.primary_price.to_f / lot.high_estimate.to_f)} / artist_lots.count.to_f
  end

  def build_artist_data(lot)
    {
      image: lot.dump["lotDetails"]["LotImages"]["GridImage"],
      saleDate: lot.dump["lotDetails"]["SaleDate"],
      extraDetails: lot.dump["extra_details"],
      title1: lot.title1,
      title2: lot.title2,
      primaryPrice: lot.primary_price,
      priceLabel: lot.price_label,
      currency: lot.currency,
      low_estimate: lot.low_estimate,
      high_estimate: lot.high_estimate
    }
  end
end
