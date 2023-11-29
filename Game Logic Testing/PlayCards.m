function newPlayedCards = PlayCards(selectedCards, playedCards)
%PLAYCARDS Summary of this function goes here
%   Detailed explanation goes here
    setSize = length(selectedCards);
    selectedCardValue = mod(selectedCards, 13);
    playedCardValue = mod(playedCards, 13);
    
    %Check if cards played are of matching value
    if setSize > 1
        for i = 1:(setSize-1)
            if not(selectedCardValue(i) == selectedCardValue(i+1))
                fprintf("Cards are not of matching value \n")
                return
            end
        end
    end

    %Check if first player
    if isempty(playedCards)
        newPlayedCards = selectedCards;
        return

    end
    
    %Check if number of cards played matches previous play
    if not(setSize == length(playedCards))
       fprintf("Does not match set size \n")
       return
    end
    
    %Check if cards played are higher value
    if selectedCardValue(1) > playedCardValue(1)
        newPlayedCards = selectedCards;
    else
        fprintf("Value of cards not high enough \n")
    end
end

