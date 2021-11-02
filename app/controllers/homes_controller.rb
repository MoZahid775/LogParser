class HomesController < ApplicationController
  def index
    @logs_data = Log.all
  end

  def new
    @log = Log.new
  end

  def create
    begin
    log_event_data = params[:log]
    log_event_data  = log_event_data.gsub(/\s+/m, ' ').gsub(/^\s+|\s+$/m, '').split(" ")
    destination = log_event_data.map{ |w| [w.gsub("dst=", "")]  if w.include?("dst=") }
    src_ip_address = log_event_data.map { |w| [w.gsub("sourceTranslatedAddress=", "")] if w.include?("sourceTranslatedAddress=") }

    event_id =  log_event_data[0]
    src_ip_address = "Source IP address : #{src_ip_address.compact.first[0]}"
    destination_ip_address = "Destination IP address: #{destination.compact.first[0]}"

    if src_ip_address && event_id && destination_ip_address
      Log.create(log_data: log_event_data, source_ip: src_ip_address,  destination_ip: destination_ip_address,  event_id: event_id )
    end
    rescue => e
      redirect_to '/'
    end
    redirect_to '/'
  end

  def destroy
    log = Log.find(params[:id])
    log.destroy
    redirect_to '/'
  end
end
