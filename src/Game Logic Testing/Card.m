classdef Card
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
        function obj = Card(number, image)
            %UNTITLED4 Construct an instance of this class
            %   Detailed explanation goes here
            obj.cardNumber = number %variable "number" will be defined by 
                                    % a 1:52 for loop in the CreateCards

            obj.cardImage = image   %
            
        end

       
    end
end