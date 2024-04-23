module FfApi
    class School
        attr_accessor(
            *%w[
                nces_id
                nces_name
                name
                level
            ]
        )
        def initialize(school_hash)
            set(school_hash)
        end

        def set(params)
            params.each { |key, value| send("#{key}=", value) }
            self
        end
    end
end
