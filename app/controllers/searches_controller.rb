class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '1F1VJIU4GOCPDW35SHGC10YB3XDMLLHEG1G3QEB01GOKOG34'
        req.params['client_secret'] = 'TGGBRBRQ355NWUZDPVN25NBJT1FL425XIK2YOA34GQ2CR000'
        req.params['v'] = '20160201'
        req.params['near'] = params[:zipcode]
        req.params['query'] = 'coffee shop'
      end
      
      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body['meta']['errorDetail']
      end

      rescue Faraday::ConnectionFailed
        @error = "There was a timeout. Please try again."
    end

    render 'search'
  end
end



# Client ID
# 1F1VJIU4GOCPDW35SHGC10YB3XDMLLHEG1G3QEB01GOKOG34

# Client Secret
# TGGBRBRQ355NWUZDPVN25NBJT1FL425XIK2YOA34GQ2CR000