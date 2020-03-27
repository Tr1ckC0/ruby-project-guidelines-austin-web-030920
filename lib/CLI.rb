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
       puts ''
       puts "Enter a number to select an option below:"
       puts "   1: Search for New Cards"
       puts "   2: View Collection" #user_card
       puts "   3: Manage Decks"
       puts ''
       puts "   * type 'exit' to quit"
    end

    def main_menu
        prompt_user
        input = get_input
        return exit if input == 'exit'
            case input
            # when 'exit'
            #     exit
            #     break
            when '1'
                search_for_new_cards
             when '2'
                view_collection
             when '3'
                decks_menu
            else
                 "Invalid command."
                main_menu
            end
    end

    def search_for_new_cards
        search_menu
    end

    def view_collection
        puts "Total cards in your collection are: #{@current_user.cards.count}"
        collection_menu
    end

    def exit
        puts ''
        puts "Happy Hunting!"
        puts ''
    end

#-----------------------------------------------SEARCH FOR NEW CARDS HELPERS -----------------------------------------------------------------
    def search_menu
        prompt_search_params
        response = get_input
        return main_menu if response == 'back'
        case response
        # when 'back'
        #     main_menu
        #     break
        when '1'
            puts ''
            puts "Please type a card name:"
            puts "(ex: archangel avacyn)"
            search = get_input.split.join('+')
            url = "https://api.magicthegathering.io/v1/cards?name=#{search}"
        when '2'
            puts ''
            puts "Please type a card color:"
            puts "(ex: red)"
            search = get_input
            url = "https://api.magicthegathering.io/v1/cards?colors=#{search}"
        when '3'
            puts ''
            puts "Please type a card type:"
            puts "(ex: creature)"
            search = get_input
            url = "https://api.magicthegathering.io/v1/cards?types=#{search}"
        else
            puts "Invalid command."
            search_menu
        end
        
        # @results = AccessAPI.new.seed_db_with_cards(url)
        @results = Card.all[0..8] ###hard code to not access API for now
        @results.each {|card| card.display_by_name_and_id}
        prompt_user_to_add_from_results

    end

    def prompt_search_params
        puts ''
        puts "Please enter a number to select from the following options:"
        puts "     1: Search by name"
        puts "     2: Search by color"
        puts "     3: Search by type"
        puts ''
        puts "     * or type 'back' to return to the main menu"
    end

    def prompt_user_to_add_from_results
        puts ''
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
        puts ''
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
            puts ''
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

    # def setup_url_by_params(num)
    #     url = nil
    #     case num
    #     when 1
    #         url = "https://api.magicthegathering.io/v1/cards?name="
    #     when 2
    #         url = "https://api.magicthegathering.io/v1/cards?colors="
    #     when 3
    #         url = "https://api.magicthegathering.io/v1/cards?types="
    #     else
    #         "Please enter valid input"
    #     end
    #     url
    # end

    # def prompt_search_terms
    #     puts "Please enter what you would like to search for:"
    # end

    # def setup_full_url(params, search)
    #     url = "#{params}" + "#{search}"
    # end

#----------------------------------------------SEARCH FOR NEW CARDS-----------------------------------------------------------------

#--------------------------------------------- VIEW THE COLLECTION ------------------------------------------------------------------

def collection_menu
    puts "Please enter a number from the following options:"
    puts "   * or type 'back' to return to main menu"
    puts "1. View all cards."
    puts "2. View all cards by color."
    puts "3. View all cards by rarity."
    response = get_input
    return main_menu if response == 'back'
        case response
        # when 'back'
        #     main_menu
        #     break
        when '1'
            view_all_cards
            collection_menu
        when '2'
            view_cards_by_color
            collection_menu
        when '3'
            view_cards_by_rarity
            collection_menu
        else 
            puts "Invalid command"
            collection_menu
        end
end

def view_all_cards
    @current_user.cards.each do |card|
        card.display
    end
end

def view_cards_by_color
    sorted_array = @current_user.cards.sort_by do |card|
        card.color
    end

    sorted_array.each do |card|
        card.display
    end
end

def view_cards_by_rarity
   sorted_array = @current_user.cards.sort_by do |card|
        card.rarity
   end

   sorted_array.each do |card|
        card.display
   end
end

#--------------------------------------------- VIEW THE COLLECTION -----------------------------------------------------------------------
#--------------------------------------------- MANAGE DECKS ------------------------------------------------------------------------------

def decks_menu
    deck_menu_prompt
    response = get_input
    return main_menu if response == 'back'
    case response
    # when 'back'
    #     main_menu
    #     break
    when '1'
        #create a new deck
    when '2'
        #view all decks
    when '3'
        #View / edit a deck
    else
        puts "Invalid command."
        decks_menu
    end
end

def deck_menu_prompt
    puts ''
    puts 'Deck Menu'
    puts ''
    puts "Please enter a number to select from the options below:"
    puts "      1. Create a new deck"
    puts "      2. View all decks"
    puts "      3. View / Edit a deck"
    puts " * or type 'back' to return to main menu"
end

def create_a_new_deck
    puts "Please enter the name of your new deck:"
    name = get_input
    puts "Please enter a number 1 - 10 to rank your deck"
    puts "i.e. '1' would be your primary deck"
    rank = get_input
    Deck.create(name: name, rank: rank, user_id: @current_user.id)
end

def view_all_decks
    @current_user.decks.sort_by {|deck| deck.rank}.each {|deck| deck.display}
    
end

def view_edit_a_deck
    
end

#--------------------------------------------- MANAGE DECKS ------------------------------------------------------------------------------

end


# def run(songs)
#     while true do
#       puts "Please enter a command:"
#       response = gets.chomp
#       case response
#       when "exit"
#         exit_jukebox
#         break
#       when "play"
#         play(songs)
#       when "help"
#         help
#       when "list"
#         list(songs)
#       else
#         puts "Invalid entry"
#       end
#     end
#   end
  
#   def play(songs)
#     puts "Please enter a song name or number:"
#     response = gets.chomp
#     if response.to_i >= 1 && response.to_i <= songs.length
#       puts "Playing #{songs[response.to_i-1]}"
#     elsif songs.include?(response)
#       puts "Playing #{songs.find{|song| song == response}}"
#     else
#       puts "Invalid input, please try again"
#     end
#   end
  
#   def exit_jukebox
#     puts "Goodbye"
#   end
  
#   def help
#   puts  "I accept the following commands:"
#   puts  "- help : displays this help message"
#   puts  "- list : displays a list of songs you can play"
#   puts  "- play : lets you choose a song to play"
#   puts  "- exit : exits this program"
#   end
  
#   def list(songs)
#   songs.each_with_index {|song, index|
#     puts "#{index+1}. #{song}"
#   }
#   end