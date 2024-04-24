require("faraday")
require("byebug")
require('ff_api/school')
require('ff_api/district')


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
            if params.is_a?(Hash)
                json = schools_as_json(params)
                schools = json["results"]
                json["results"] = schools.map { |school_hash| FfApi::School.new(school_hash) }
                json
            else
                FfApi::School.new(schools_as_json)
            end
        end

        def schools_as_json(params = {})
            connection = Faraday.new(url: base_url)
            if params.is_a?(Hash)
                response = connection.get("schools.json", params) do |request|
                    request.headers["Authorization"] = "Bearer #{api_key}"
                end
                if response.status == 200
                    JSON.parse(response.body)
                else
                    respond_to_error(response)
                end
            else
                response = connection.get("school/#{params}.json") do |request|
                    request.headers["Authorization"] = "Bearer #{api_key}"
                end
                if response.status == 200
                    JSON.parse(response.body)
                else
                    respond_to_error(response)
                end
            end
        end

        def districts(params = {})
            connection = Faraday.new(url: base_url)
            if params.is_a?(Hash)
                json = districts_as_json(params)
                districts = json["results"]
                json["results"] = districts.map { |district_hash| FfApi::District.new(district_hash) }
                json
            else
                FfApi::District.new(districts_as_json)
            end
        end

        def districts_as_json(params = {})
            connection = Faraday.new(url: base_url)
            if params.is_a?(Hash)
                response = connection.get("districts.json", params) do |request|
                    request.headers["Authorization"] = "Bearer #{api_key}"
                end
                if response.status == 200
                    JSON.parse(response.body)
                else
                    respond_to_error(response)
                end
            else
                response = connection.get("district/#{params}.json") do |request|
                    request.headers["Authorization"] = "Bearer #{api_key}"
                end
                if response.status == 200
                    JSON.parse(response.body)
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
