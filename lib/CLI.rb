class CLI
    

    def run
        greeting
        user_login
        main_menu
        puts "Goodbye"
    end
    
    def greeting
        puts '-' * 100
        puts ''
        puts "Welcome to the Magic Manager"
        puts ''
        puts '-' * 100
        puts ''
        puts 'Here you can keep your Magic the Gathering collection organized.'
        puts ''
        puts 'Please enter a USERNAME and PASSWORD to begin.'
    end

    def user_login
        puts "username:"
        # username = get_input
        username = "tr1ckC0"
        puts "password:"
        # password = get_input
        password = "123456789"
        @current_user = User.find_or_create_by(username: username, password: password)
        ####to authenticate
                #find or creat by username
                #if password == nil
                    #user.password = password
                #elsif password == user.password
                    #sign-in successful
                #else 
                    #password and username do not match.. please try again
        ####to authenticate
    end

    def get_input
        gets.chomp
    end

    def prompt_user
       puts ''
       puts "MAIN MENU"
       puts '-' * 30
       prompt = TTY::Prompt.new
       prompt.select("Select an option below:", ["Search for New Cards", "View Collection", 
       "ManageDecks", "Exit"])
    #    puts "Enter a number to select an option below:"
    #    puts "   1: Search for New Cards"
    #    puts "   2: View Collection" #user_card
    #    puts "   3: Manage Decks"
    #    puts ''
    #    puts "   * type 'exit' to quit"
    end

    def main_menu
        input = prompt_user
        return exit if input == "Exit"
            case 
            # when 'exit'
            #     exit
            #     break
            when 'Search_for_New_Cards'
                search_for_new_cards
             when 'View_Collection'
                view_collection
             when 'Manage_Decks'
                decks_menu
            end
    end

    def search_for_new_cards
        search_menu
    end

    def view_collection
        collection_menu
    end

    def exit
        puts ''
        puts '-' * 100
        puts ''
        puts "Happy Hunting!"
        puts ''
        puts '-' * 100
        puts ''
    end

#-----------------------------------------------SEARCH FOR NEW CARDS HELPERS -----------------------------------------------------------------
    def search_menu
        response = prompt_search_params
        return main_menu if response == 'Back'
        case response
        when "Search by name"
            puts ''
            puts "Please type a card name:"
            puts "(ex: archangel avacyn)"
            search = get_input.split.join('+')
            url = "https://api.magicthegathering.io/v1/cards?name=#{search}"
        when "Search by color"
            puts ''
            puts "Please type a card color:"
            puts "(ex: red)"
            search = get_input
            url = "https://api.magicthegathering.io/v1/cards?colors=#{search}"
        when "Search by type"
            puts ''
            puts "Please type a card type:"
            puts "(ex: creature)"
            search = get_input
            url = "https://api.magicthegathering.io/v1/cards?types=#{search}"
        end
        
        @results = AccessAPI.new.seed_db_with_cards(url)
        # @results = Card.all[0..8] ###hard code to not access API for now
        @results.each {|card| card.display_by_name_and_id}
        puts "-" * 30
        prompt_user_to_add_from_results

    end

    def prompt_search_params
        puts ''
        puts 'Search Menu'
        puts '-' * 30
        prompt = TTY::Prompt.new
        prompt.select("Select an option below:", ["Search by name", "Search by color", 
        "Search by type", "Back"])
        # puts "Please enter a number to select from the following options:"
        # puts "     1: Search by name"
        # puts "     2: Search by color"
        # puts "     3: Search by type"
        # puts ''
        # puts "     * or type 'back' to return to the main menu"
    end

    def prompt_user_to_add_from_results
        puts '-' * 30
        puts "Please enter a number to select from the options below:"
        puts "     1. View full card details"
        puts "     2. Add cards to your collection"
        puts "     3. Make another search"
        puts ''
        puts "     * or type 'back' to return to the main menu"
        input = get_input
        return main_menu if input == 'back'
            case input
            # when 'back'
            #     main_menu
            #     break
            when '1'
                view_full_details_from_results
            when '2'
                search_add_cards_menu
            when '3'
                search_menu
            else
                "Invalid command"
                prompt_user_to_add_from_results
            end
    end

    def view_full_details_from_results
        puts '-' * 30
        puts "Please enter the card ID to view details:"
        puts "(or type 'all' to view all)"
        puts ''
        puts "*type 'back' to return to the previous menu"
        response = get_input

        return prompt_user_to_add_from_results if response == 'back'
        if response == 'all'
            @results.each {|card| card.display}
            view_full_details_from_results

        elsif @results.map {|card| card.id}.include?(response.to_i)
                @results.find {|card| card.id == response.to_i}.display
            view_full_details_from_results

        else
            puts "Invalid command."
            view_full_details_from_results

        end
    end
        
        def search_add_cards_menu
            puts '-' * 30
            puts "Please enter the card ID to add:"
            puts "(or type 'all' to add all)"
            puts ''
            puts "*type 'back' to return to the previous menu"
            response = get_input
            return prompt_user_to_add_from_results if response == 'back'
            
            if response == 'all'
                @results.each do |card|
                @current_user.user_cards.find_or_create_by(
                    user_id: @current_user.id,
                    card_id: card.id
                )
                end
                puts ''
                puts "All cards added"
                prompt_user_to_add_from_results

            elsif @results.map {|card| card.id}.include?(response.to_i)
                    @current_user.user_cards.find_or_create_by(user_id: @current_user.id, card_id: response.to_i)
                    puts ''
                    puts "Card Added Successfully"
                    search_add_cards_menu

            else
                puts "Invalid command."
                search_add_cards_menu
        
            end    
        end
    

    # def build_url
    #     prompt_search_params
    #     num = get_input.to_i
    #     case num
    #     when 1
    #         puts "Please type a card name:"
    #         search = get_input
    #         url = "https://api.magicthegathering.io/v1/cards?name=#{search}"
    #     when 2
    #         puts "Please type a card color:"
    #         search = get_input
    #         url = "https://api.magicthegathering.io/v1/cards?colors=#{search}"
    #     when 3
    #         puts "Please type a card type:"
    #         search = get_input
    #         url = "https://api.magicthegathering.io/v1/cards?name=#{search}"
    #     else
    #         puts "Invalid command."
    #         build_url
    #     end
    #     url
    # end

#----------------------------------------------SEARCH FOR NEW CARDS-----------------------------------------------------------------

#--------------------------------------------- VIEW THE COLLECTION ------------------------------------------------------------------

def collection_menu
    while true do

    collection_menu_prompt
    response = get_input
    
    # return main_menu if response == 'back'
        case response
        when 'back'
            main_menu
            break
        when '1'
            view_all_cards
            # collection_menu
        when '2'
            view_cards_by_color
            # collection_menu
        when '3'
            view_cards_by_rarity
            # collection_menu
        else 
            puts "Invalid command"
            # collection_menu
        end
    end
end

def collection_menu_prompt
    puts ''
    puts "Collection Menu"
    puts "-" * 30
    puts "Please enter a number from the following options:"
    puts "   1. View all cards."
    puts "   2. View all cards by color."
    puts "   3. View all cards by rarity."
    puts ''
    puts "   * or type 'back' to return to main menu"
end

def view_all_cards
    puts "You have #{@current_user.cards.count} cards in your collection"
    @current_user.cards.each do |card|
        card.display_by_name_and_id
    end
    puts ''
    puts "Press enter to return"
    get_input
end

def view_cards_by_color
    puts "You have #{@current_user.cards.count} cards in your collection"
    @current_user.cards.sort_by {|card| card.color}.each {|card| card.display_by_color}
    puts ''
    puts "Press enter to return"
    get_input
end

def view_cards_by_rarity
    puts "You have #{@current_user.cards.count} cards in your collection"
    @current_user.cards.sort_by {|card| card.rarity}.each {|card| card.display_by_rarity}
    puts ''
    puts "Press enter to return"
    get_input
end

#--------------------------------------------- VIEW THE COLLECTION -----------------------------------------------------------------------
#--------------------------------------------- MANAGE DECKS ------------------------------------------------------------------------------

    def decks_menu
        # while true do
        deck_menu_prompt
        response = get_input
        return main_menu if response == 'back'
            case response
            # when 'back'
            #     main_menu
            #     break
            when '1'
                create_a_new_deck
            when '2'
                view_all_decks
            when '3'
                view_edit_a_deck
            else
                puts "Invalid command."
                decks_menu
            end
        # end
    end

    def deck_menu_prompt
        puts ''
        puts 'Deck Menu'
        puts '-' * 30
        puts "Please enter a number to select from the options below:"
        puts "      1. Create a new deck"
        puts "      2. View all decks"
        puts "      3. View / Edit a deck"
        puts ''
        puts "      * or type 'back' to return to main menu"
    end

    def create_a_new_deck
        puts "Please enter the name of your new deck:"
        name = get_input
        puts "Please enter a number 1 - 10 to rank your deck"
        puts "i.e. '1' would be your primary deck"
        rank = get_input.to_i

        Deck.create(title: name, rank: rank, user_id: @current_user.id)

        puts "Deck created"
        puts "NAME: #{name}, RANK: #{rank}"
        puts ''
        puts 'Press enter to return'
        get_input
        decks_menu
    end

    def view_all_decks
        puts "Your current decks"
        puts '-' * 50
        @current_user.decks.sort_by {|deck| deck.rank}.map {|deck| deck.display}
        puts ''
        puts "Please press enter to return"
        get_input
        decks_menu
    end

    def view_edit_a_deck_prompt
        puts ''
        puts 'Deck Editor'
        puts ''
        puts "Please enter a number to select from the options below:"
        puts "      1. View Deck"
        puts "      2. Add a card to your Deck"
        puts "      3. Remove a card from your Deck"
        puts ''
        puts "      * or type 'back' to return to decks menu"
    end

    def select_deck
        i = 1
        puts "Please enter a number to select a Deck."
        @current_user.decks.each do |deck|
            puts "#{i}. #{deck.title}"
            i += 1
        end
        index = get_input.to_i
            @current_user.decks[index - 1]
    end

    def view_edit_a_deck
        # while true do
            view_edit_a_deck_prompt
            response = get_input
            return decks_menu if response == 'back'
            case response
            # when 'back'
            #     decks_menu
            #     break
            when '1'
                view_deck
            when '2'
                add_a_card
            when '3'
                remove_a_card
            else
                puts "Invalid command."
                view_edit_a_deck
            end
        # end
    end

    def view_deck
        deck = select_deck
        if deck.cards.empty?
            puts "No cards found!"
        else
        view_all_cards_in_deck(deck)
        end
        puts ''
        puts "Please press enter to return"
        get_input
        view_edit_a_deck
    end

    def view_all_cards_in_deck(deck)
        puts "All the cards in #{deck.title}"
        puts '-' * 20
        deck.cards.each {|card| card.display_by_name_and_id}
    end

    def add_a_card
        deck = select_deck
        view_all_cards
        puts "Above is your card collection"
        puts "Please enter the name of the card you would like to add:"
        card_name = get_input
        card = @current_user.cards.find_by(name: card_name)
        DeckCard.create(deck_id: deck.id, card_id: card.id)
        puts "#{card.name} Added Successfully to #{deck.title}"
        puts ''
        puts 'Add another card? y / n'
        response = get_input
        if response.first == 'y' || response.first == 'Y'
            add_a_card
        else
            view_edit_a_deck
        end
    end

    def remove_a_card
        deck = select_deck
        view_all_cards_in_deck(deck)
        puts "Please enter the name of the card you would like to remove:"
        card_name = get_input
        card = @current_user.cards.find_by(name: card_name)
        DeckCard.find_by(deck_id: deck.id, card_id: card.id).destroy
        deck.cards.delete(card)
        puts "#{card.name} Removed Successfully from #{deck.title}"
        puts ''
        puts 'Remove another card? y / n'
        response = get_input
        if response.first == 'y' || response.first == 'Y'
            remove_a_card
        else
            view_edit_a_deck
        end
    end
#--------------------------------------------- MANAGE DECKS ------------------------------------------------------------------------------
end
