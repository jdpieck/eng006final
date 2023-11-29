function playerDecks = InitalizeDecks(numPlayers)
%INITALIZE DECKS - Resets deck for start of game
%INPUTS - numPayers = number of players 
%OUTPUTS - Array with rows being player cards
    

    %Create random order of 52 unique cards
    cards = randperm(52); 
    
    %How many players are there?
    switch numPlayers
        case 3 
            playerDecks = zeros(3, 18);
            playerDecks(1, :) = cat(2, [cards(1:17), 0]);   %Deck 1
            playerDecks(2, :) = cat(2, [cards(18:34), 0]);  %Deck 2
            playerDecks(3, :) = cards(35:52);               %Deck 3
        case 4
            playerDecks = zeros(4, 13);
            for i = 1:4 %Create 4 equal decks
                playerDecks(i, :) = cards((13*i - 12): 13*i);
            end
        otherwise
            fprintf("Number of players not supported \n")
    end 

end

