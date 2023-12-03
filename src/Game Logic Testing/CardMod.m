classdef CardMod
    %Card: Contains constructor function used to create a card
    % cardNumber order: 4 suits of cards, 13 cards per suit, order of suits 
    % is clubs, diamonds, hearts, spades, order of cards is 2,3...king,ace

    properties
        cardNumber;     %number of card in list of all 52
        cardImage;      %image of card, string variable referencing image 
                        % in folder
    end

    methods
        % Card
        function obj = CardMod(number, image)
            obj.cardNumber = number 
            obj.cardImage = image               
        end     
    end
end