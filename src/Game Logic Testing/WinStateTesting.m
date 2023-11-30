function [gameState, winRow] = WinStateTesting(numPlayers)
%WinState: Check if a "Win State" (row of all 0's) exists for any
%player

% Outputs:
% gameState = Variable containing a string that can be assesed by a seperate 
% function to determine if a WinState exists in a player's Deck
% winRow = Variable containing which row of playerDecks contains the
% "Win State". winRow = 0 indicates no player has won 
% Inputs:
    % playerDecks: array containing the deck of a player in each of its
     % rows, created in InitializeDecks. This code depends on the value of
     % an element in playerDecks becoming "0" after its corresponding card
     % is played. The code can be rewritten with a different variable if
     % playerDecks does not function in this way.
    %numPlayers: variable for number of players used in InitializeDecks
% Elements
    % Switch/Case  to operate differently based on # of players 
    % Embedded for loop to loop through each row of PlayerDecks, uses
      % sum of logical
    %Embedded case statement to assign different string to gameState
     %depending on result 

%For Testing: Remove playerDecks from inputArgs and create the array using
%testing code below
%After Testing: add playerDecks to inputArgs and comment out testing code


% Testing Code:

cards = randperm(52); 

switch numPlayers % For testing
        case 3 %there are three players
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

%playerDecks(1,:) = zeros(1,18);
% playerDecks(2,:) = zeros(1,18);
%playerDecks(3,:) = zeros(1,18);
% playerDecks(4,:) = zeros(1,18);

%playerDecks(1,:) = zeros(1,13);
% playerDecks(2,:) = zeros(1,13);
%playerDecks(3,:) = zeros(1,13);
% playerDecks(4,:) = zeros(1,13);


% Testing Code ^


switch numPlayers
    case 3 
        for i = 1:3
            playersHand = playerDecks(i,:); %isolates one player's hand
            summedHand = sum(playersHand); %sums all the values of that players hand
            if summedHand == 0  %Checks if hand sums to 0, meaning the hand is empty
                gameState = "Round Complete";
                winRow = i
                break
            else 
                gameState = "Round Incomplete";
                winRow = 0 
            end 
        end 
 


    case 4
         for i = 1:4
            playersHand = playerDecks(i,:); %isolates one player's hand
            summedHand = sum(playersHand); %sums all the values of that players hand
            if summedHand == 0  %Checks if hand sums to 0, meaning the hand is empty
                gameState = "Round Complete";
                winRow = i
                break
            else 
                gameState = "Round Incomplete";
                winRow = 0
            end
         end

end 


end