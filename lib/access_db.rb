class AccessAPI
    def get_response(url)
        RestClient.get "#{url}"
    end

    def get_parse(url)
        response = get_response(url)
        JSON.parse(response)
    end
end