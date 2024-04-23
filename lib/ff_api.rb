require("faraday")
require("byebug")
require('ff_api/school')


module FfApi
    class V1
        attr_accessor(:api_key)

        def initialize(api_key:)
            self.api_key = api_key
        end

        def base_url
            "http://dev-oh.finalforms.me:8080/api/v1"
        end

        def schools(params = {})
            connection = Faraday.new(url: base_url)
            response = connection.get("schools.json", params) do |request|
                request.headers["Authorization"] = "Bearer #{api_key}"
            end
            if response.status == 200
                schools = JSON.parse(response.body)
                schools.map { |school_hash| FfApi::School.new(school_hash) }
            else
                respond_to_error(response)
            end
        end

        def districts(params = {})
            connection = Faraday.new(url: base_url)
            if params.is_a?(Hash)
                response = connection.get("districts.json", params) do |request|
                    request.headers["Authorization"] = "Bearer #{api_key}"
                end
                if response.status == 200
                    schools = JSON.parse(response.body)
                    schools.map { |school_hash| FfApi::School.new(school_hash) }
                else
                    respond_to_error(response)
                end
            else
                response = connection.get("district/#{params}.json") do |request|
                    request.headers["Authorization"] = "Bearer #{api_key}"
                end
                if response.status == 200
                    schools = JSON.parse(response.body)
                    schools.map { |school_hash| FfApi::School.new(school_hash) }
                else
                    respond_to_error(response)
                end
            end
        end

        def respond_to_error(response)
            body = JSON.parse(response.body)
            body.merge(status: response.status)
        end


    end

end
