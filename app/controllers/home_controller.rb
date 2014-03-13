class HomeController < ApplicationController
  skip_authorization_check
  def index
    @ip_info = Geolocate.find(request.ip)
    # raise request.inspect
  end
end
