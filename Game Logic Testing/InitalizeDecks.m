function playerDecks = InitalizeDecks(numPlayers)
%INITALIZE DECKS Summary of this function goes here
%   Detailed explanation goes here
    %Create random order of 52 unique cards
    cards = randperm(52); 
    
    switch numPlayers
        case 3
            playerDecks = zeros(3, 18);
            playerDecks(1, :) = cat(2, [cards(1:17), 0]);
            playerDecks(2, :) = cat(2, [cards(18:34), 0]);
            playerDecks(3, :) = cards(35:52);
        case 4
            playerDecks = zeros(4, 13);
            for i = 1:4
                playerDecks(i, :) = cards((13*i - 12): 13*i);
            end
        otherwise
            fprintf("Number of players not supported \n")
    end 

end

