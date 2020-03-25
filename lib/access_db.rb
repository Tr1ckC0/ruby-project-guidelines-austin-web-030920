class AccessAPI
    def get_response(url)
        RestClient.get "#{url}"
    end

    def get_parse(url)
        response = get_response(url)
        JSON.parse(response)
    end

    def filter_mtg_api(search_terms)
        data = AccessAPI.new.get_parse("https://api.magicthegathering.io/v1/cards")

        card_data = []
        data["cards"].each do |card|
            hash = {
                name:               card["name"],
                mana_cost:          card["manaCost"],
                total_mana_cost:    card["cmc"],
                color:              card["colors"].first,
                mana_type:          card["colorIdentity"].join(', '),
                types:              card["types"].join('/'),
                subtypes:           card["subtypes"].join('/'),
                rarity:             card["rarity"],
                set:                card["setName"],
                text:               card["text"],
                power:              card["power"],
                toughness:          card["toughness"],
                legality:           card["legalities"][0]["legality"],
                imageURL:           card["imageUrl"]}
        card_data << hash
        end
        card_data
    end

    def seed_db_with_cards
       card_data = filter_mtg_api
       
       card_data.map do |card|
        Card.find_or_create_by(
                name:               card[:name],
                mana_cost:          card[:mana_cost],
                total_mana_cost:    card[:total_mana_cost],
                color:              card[:color],
                mana_type:          card[:mana_type],
                types:              card[:types],
                subtypes:           card[:subtypes],
                rarity:             card[:rarity],
                set:                card[:set],
                text:               card[:text],
                power:              card[:power],
                toughness:          card[:toughness],
                legality:           card[:legality],
                imageURL:           card[:imageURL]
            )
       end
    end
end