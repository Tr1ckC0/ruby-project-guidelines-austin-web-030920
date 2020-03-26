class CLI

    def run
        greeting
        user_login
        main_menu
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
        username = "jnuzzi"
        puts "password:"
        # password = get_input
        password = "asdf"
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
        case input
        when '1'
            search_for_new_cards
        when '2'
            view_collection
        when '3'
            manage_decks
        when 'exit'
            puts ''
            puts 'Goodbye.'
            puts ''
        else
            "Invalid command."
            main_menu
        end
    end

#-----------------------------------------------SEARCH FOR NEW CARDS -----------------------------------------------------------------

    def search_for_new_cards
        prompt_search_params
        num = get_input.to_i
        case num
        when 1
            puts ''
            puts "Please type a card name:"
            search = get_input
            url = "https://api.magicthegathering.io/v1/cards?name=#{search}"
        when 2
            puts ''
            puts "Please type a card color:"
            search = get_input
            url = "https://api.magicthegathering.io/v1/cards?colors=#{search}"
        when 3
            puts ''
            puts "Please type a card type:"
            search = get_input
            url = "https://api.magicthegathering.io/v1/cards?name=#{search}"
        else
            puts "Invalid command."
            search_for_new_cards
        end
        
        # @results = AccessAPI.new.seed_db_with_cards(url)
        @results = Card.all[0..8] ###hard code to not access API for now
        @results.each {|card| card.display}
        prompt_user_to_add_from_results
    end

    def prompt_search_params
        puts ''
        puts "Enter a number based on how you would like to search:"
        puts "     1: Search by name"
        puts "     2: Search by color"
        puts "     3: Search by type"
    end

    def prompt_user_to_add_from_results
        puts ''
        puts "Would you like to add any of these cards to your collection?"
        puts "'Yes' to add cards"
        puts "'No' to return to main menu"
        input = get_input
            
        if input == "y" || input == "yes" || input == "Y" || input == "Yes"
            puts ''
            puts "Please type the card ID (located in the top right corner of the card info)"
            puts "* or type 'all' to add cards"
            #seperate method
            response = get_input
        
            if response == 'all'
               @results.each do |card|
                @current_user.user_cards.find_or_create_by(
                    user_id: @current_user.id,
                    card_id: card.id
                )
               end
                puts ''
                puts "All cards added"
                main_menu

            elsif @results.map {|card| card.id}.include?(response.to_i)
                @current_user.user_cards.find_or_create_by(user_id: @current_user.id, card_id: response)
                puts ''
                puts "Card Added Successfully"
                prompt_user_to_add_from_results

            else
                puts "Invalid command."
                prompt_user_to_add_from_results
                #seperate method call
            end

        elsif input == 'n' || input == 'no' || input == "N" || input == 'No'
            main_menu
        else
            puts ''
            puts "Invalid command."
            prompt_user_to_add_from_results
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
def view_collection
    puts "Total cards in your collection are: #{@current_user.cards.count}"
    collection_menu
end

def collection_menu
    puts "Please enter a number from the following options:"
    puts "   * or type 'back' to return to main menu"
    puts "1. View all cards."
    puts "2. View all cards by color."
    puts "3. View all cards by rarity."
    response = get_input
    case response
    when '1'
        view_all_cards
        collection_menu
    when '2'
        view_cards_by_color
        collection_menu
    when '3'
        view_cards_by_rarity
        collection_menu
    when 'back'
        main_menu
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
end


#--------------------------------------------- MANAGE DECK ----------------------------------------------------------------------

def manage_decks
    manage_decks_prompt
    response = get_input
    case response
    when '1'
        create_a_new_deck
    when '2'
        view_all_decks
    when '3'
        view_edit_a_deck
    when 'back'
        main_menu
    else
        puts "Invalid command."
        decks_menu
    end
end
def manage_decks_prompt
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
    rank = get_input.to_i
    Deck.create(title: name, rank: rank, user_id: @current_user.id)
    puts "Deck created"
    puts "#{name}, #{rank}, and #{@current_user.id}"
end
def view_all_decks
    @current_user.decks.sort_by {|deck| deck.rank}.each {|deck| deck.display}

# Make look pretty later

end

def view_edit_a_deck
    view_edit_a_deck_prompt
    response = get_input
    case response
    when '1'
        #view_deck
    when '2'
        #add_card
    when '3'
        #remove_card
    when 'back'
        decks_menu
    else
        puts "Invalid command."
        decks_menu
    end
end

def view_edit_a_deck_prompt
    puts ''
    puts 'Deck Editor'
    puts ''
    puts "Please enter a number to select from the options below:"
    puts "      1. View Deck"
    puts "      2. Add a card to your Deck"
    puts "      3. Remove a card from your Deck"
    puts " * or type 'back' to return to decks menu"
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

def view_deck
    puts "Please enter Deck Name"
    response = get_input
    Deck.each (user.id, name, rank)

end

def add_a_card

end
end

#----------------------------------------------- MANAGE DECK --------------------------------------------------------------------



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