require "rest_client"
require "json"

module PayFabric
  # 
  #  `GatewayAccount` provides methods for work with Gateway account profiles
  #  Include two submodules  
  #  `Sandbox` for work with sandbox api
  #  `Live` for work with production api
  #
  module GatewayAccount
    module Share #:nodoc:
      extend self

      def retrieve_all(url, device_id, password) #:nodoc:
        response = RestClient.get(url, 
          PayFabric::headers(device_id, password, url.include?("sandbox")))
        JSON.parse(response.body)
      end

      def retrieve(url, device_id, password) #:nodoc:
        response = RestClient.get(url, 
          PayFabric::headers(device_id, password, url.include?("sandbox")))
        JSON.parse(response.body)
      end   
    end

    module Sandbox
      extend self 
      #  ## Retrieve All Gateway Account Profiles
      #  [Info](https://github.com/PayFabric/APIs/wiki#retrieve-all-gateway-account-profiles)
      #
      #  Example
      #    
      #    array = PayFabric::GatewayAccount::Sandbox::retrieve_all(device_id, password)  
      #    array # => 
      #      [
      #        {"ID" => "123"}, {"ID" => "124"}, {"ID" => "125"}  
      #      ]
      #    
      #  @return [Array of Gateway Account](https://github.com/PayFabric/APIs/wiki/API-Objects#gateway-account)
      #
      def retrieve_all(device_id, password)
        url = "https://sandbox.payfabric.com/rest/v1/api/setupid"
        Share::retrieve_all(url, device_id, password)
      end  

      #  ## Retrieve a Gateway Account Profile By Id
      #  [Info](https://github.com/PayFabric/APIs/wiki#retrieve-a-gateway-account-profile-by-id)
      #
      #  +id+ - profile id 
      # 
      #  Example
      # 
      #    id = "10" 
      #    hash = PayFabric::GatewayAccount::Sandbox::retrieve(device_id, password, id) 
      #    hash # => {"ID" => "123"} 
      #
      # @return [Gateway Account](https://github.com/PayFabric/APIs/wiki/API-Objects#gateway-account)
      #
      def retrieve(device_id, password, id)
        url = "https://sandbox.payfabric.com/payment/api/setupid/#{id}"
        Share::retrieve(url, device_id, password)
      end
    end

    module Live
      extend self 
      # see Sandbox::retrieve_all
      def retrieve_all(device_id, password)
        url = "https://payfabric.com/payment/api/setupid"
        Share::retrieve_all(url, device_id, password)
      end  
      # see Sandbox::retrieve
      def retrieve(device_id, password, id)
        url = "https://payfabric.com/payment/api/setupid/#{id}"
        Share::retrieve(url, device_id, password)
      end
    end
  end
end
