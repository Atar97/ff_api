module FfApi
    class District
        attr_accessor(
            *%w[
                nces_id
                nces_name
                name
                address
                schools
            ]
        )
        def initialize(district)
            set(district)
        end

        def set(params)
            params.each { |key, value| send("#{key}=", value) }
            self
        end

    end
end
