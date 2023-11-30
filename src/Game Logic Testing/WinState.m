function [gameState, winRow] = WinState(playerDecks,numPlayers)
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

