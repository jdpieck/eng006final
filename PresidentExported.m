classdef PresidentExported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        YourPlayerNumberEditField       matlab.ui.control.NumericEditField
        YourPlayerNumberEditFieldLabel  matlab.ui.control.Label
        ResetLobbyButton                matlab.ui.control.Button
        Fireworks                       matlab.ui.control.Image
        Congrats                        matlab.ui.control.Image
        RightLuigi                      matlab.ui.control.Image
        LeftLuigi                       matlab.ui.control.Image
        MessageLabel                    matlab.ui.control.Label
        ErrorDisplay                    matlab.ui.control.Image
        SuccessDisplay                  matlab.ui.control.Image
        Button_413                      matlab.ui.control.StateButton
        Button_412                      matlab.ui.control.StateButton
        Button_411                      matlab.ui.control.StateButton
        Button_410                      matlab.ui.control.StateButton
        Button_409                      matlab.ui.control.StateButton
        Button_408                      matlab.ui.control.StateButton
        Button_407                      matlab.ui.control.StateButton
        Button_406                      matlab.ui.control.StateButton
        Button_405                      matlab.ui.control.StateButton
        Button_404                      matlab.ui.control.StateButton
        Button_403                      matlab.ui.control.StateButton
        Button_402                      matlab.ui.control.StateButton
        Button_401                      matlab.ui.control.StateButton
        Button_313                      matlab.ui.control.StateButton
        Button_312                      matlab.ui.control.StateButton
        Button_311                      matlab.ui.control.StateButton
        Button_310                      matlab.ui.control.StateButton
        Button_309                      matlab.ui.control.StateButton
        Button_308                      matlab.ui.control.StateButton
        Button_307                      matlab.ui.control.StateButton
        Button_306                      matlab.ui.control.StateButton
        Button_305                      matlab.ui.control.StateButton
        Button_304                      matlab.ui.control.StateButton
        Button_303                      matlab.ui.control.StateButton
        Button_302                      matlab.ui.control.StateButton
        Button_301                      matlab.ui.control.StateButton
        Button_213                      matlab.ui.control.StateButton
        Button_212                      matlab.ui.control.StateButton
        Button_211                      matlab.ui.control.StateButton
        Button_210                      matlab.ui.control.StateButton
        Button_209                      matlab.ui.control.StateButton
        Button_208                      matlab.ui.control.StateButton
        Button_207                      matlab.ui.control.StateButton
        Button_206                      matlab.ui.control.StateButton
        Button_205                      matlab.ui.control.StateButton
        Button_204                      matlab.ui.control.StateButton
        Button_203                      matlab.ui.control.StateButton
        Button_202                      matlab.ui.control.StateButton
        Button_201                      matlab.ui.control.StateButton
        Button_1                        matlab.ui.control.StateButton
        Button_2                        matlab.ui.control.StateButton
        Button_3                        matlab.ui.control.StateButton
        Button_4                        matlab.ui.control.StateButton
        Button_113                      matlab.ui.control.StateButton
        Button_112                      matlab.ui.control.StateButton
        Button_111                      matlab.ui.control.StateButton
        Button_110                      matlab.ui.control.StateButton
        Button_109                      matlab.ui.control.StateButton
        Button_108                      matlab.ui.control.StateButton
        Button_107                      matlab.ui.control.StateButton
        Button_106                      matlab.ui.control.StateButton
        Button_105                      matlab.ui.control.StateButton
        Button_104                      matlab.ui.control.StateButton
        Button_103                      matlab.ui.control.StateButton
        Button_102                      matlab.ui.control.StateButton
        Button_101                      matlab.ui.control.StateButton
        WhosUpPlayerLabel               matlab.ui.control.Label
        Label                           matlab.ui.control.Label
        WhosUpBox                       matlab.ui.control.Image
        ConfirmButton                   matlab.ui.control.Button
        HowManyPlayersEditField         matlab.ui.control.NumericEditField
        HowManyPlayersEditFieldLabel    matlab.ui.control.Label
        HomeButton                      matlab.ui.control.Button
        JoinGameButton                  matlab.ui.control.Button
        PlayButton                      matlab.ui.control.Button
        RulesButton                     matlab.ui.control.Button
        Player3Label                    matlab.ui.control.Label
        Player1Label                    matlab.ui.control.Label
        Player2Label                    matlab.ui.control.Label
        Player4Label                    matlab.ui.control.Label
        PlayCardsButton                 matlab.ui.control.Button
        SkipTurnButton                  matlab.ui.control.Button
        PresidentTitle                  matlab.ui.control.Image
        Player3Box                      matlab.ui.control.Image
        Player1Box                      matlab.ui.control.Image
        Player4Box                      matlab.ui.control.Image
        Player2Box                      matlab.ui.control.Image
    end

    properties (Access = public)
        % Cards
        gameDeck = 0        % Array of all 52 Cards
        playerDecks         % MxN array with M = # of players & N = number of cards
        playedCards = 0     % Cards on the table
        
        % Turn Progression
        turnCount = 1       % Tracks how many turns have passed
        playerTurn = 1      % Which player's turn is it? Based on playerPriority loop, not actual player number
        skipCount = 0       % # of turns skipped in a round
        gameState           % Is the round over?
        
        % Player Info
        numPlayers = 2     % (CHANGE) number of player 
        playerID            % (ONLINE ONLY) player playing on app
        winPlayer = 0       % Who won the round
        playerWins          % Number of wins

        % Online 
        isOnline = false    % Is the game happening online
        lobbyState = false  % (ONLINE ONLY) Has an online game already been started?
        duration = 1        % (ONLINE ONLY) How long to wait between ThingSpeak Commands
        userAPIKey = '7XEAHMX5E7JA3NVM';
        channelID = 2368599;
        readKey = 'LLHWWTB3K780X5S1';
        writeKey = 'XH18T2Q11AQPS9PA';
    end
    
    methods (Access = public)
        %% Buttons
        function imageArray = CallImage(~, cardArray)    % What is the image name of the card?
            imageArray = cardArray + ".png";
        end
        
        function [] = UpdateButtonIcons(app, buttonRange, inputDeck)
            imageButton = CallImage(app, inputDeck);
            for i = buttonRange
                buttonName = "Button_" + i;
                app.(buttonName).Icon = imageButton(mod(i,100));
            end
        end
        
        function [] = UpdateButtonVisible(app, buttonRange, state)
            for i = buttonRange
                buttonName = "Button_" + i;
                app.(buttonName).Visible = state;
            end
        end
        
        function [] = UpdateButtonValue(app, buttonRange, state)
            for i = buttonRange
                buttonName = "Button_" + i;
                app.(buttonName).Value = state;
            end
         end

        function statesArray = CheckButtonStates(app, buttonRange)
            statesArray = zeros(1, length(buttonRange));
            for i = buttonRange
                buttonName = "Button_" + i;
                statesArray(mod(i,100)) = app.(buttonName).Value;
            end
            statesArray = logical(statesArray);
        end

        %% Player Turn
        function [] = CheckPlayerTurn(app)
            if app.isOnline
                app.turnCount = ReadArray(app, 4);
                app.playerTurn = mod(app.turnCount, app.numPlayers);
                if app.playerTurn == 0
                    app.playerTurn = app.numPlayers;    
                end 
                app.Label.Text = string(app.playerTurn);
            else
                error("Cannot check player turn since game is not online \n")
            end
        end

        function [] = IncreasePlayerTurn(app)
            if app.isOnline
                app.turnCount = ReadArray(app, 4);
            end

            app.turnCount = app.turnCount + 1;
            app.playerTurn = mod(app.turnCount, app.numPlayers);
                if app.playerTurn == 0
                    app.playerTurn = app.numPlayers;
                end 
            fprintf("It is turn %g and the next player is %g \n", app.turnCount, app.playerTurn)

            app.Label.Text = string(app.playerTurn);
        end

        function [] = PlayerTurnLock(app)
            if app.isOnline
                % fprintf("It is Player %g's turn \n", app.playerTurn)

                isMyTurn = app.playerTurn == app.playerID;
                if ~isMyTurn
                    fprintf("It is now Player %g's turn \n", app.playerTurn)
                    app.PlayCardsButton.Visible = "off";
                    app.SkipTurnButton.Visible = "off";

                    time = 0;
                    while ~isMyTurn
                        time = time + 1;
                        fprintf("It has been %g seconds since your last turn \n", time)
                        currentCount = ReadArray(app, 4);
                        isMyTurn = currentCount == app.turnCount + 1;
                        pause(app.duration)
                        app.gameDeck = ReadArray(app, 2);
                        DecodeDeck(app)
                    end
                end

                app.PlayCardsButton.Visible = "on";
                app.SkipTurnButton.Visible = "on";
                app.playedCards = ReadArray(app, 3);
                CheckPlayerTurn(app)

                UpdateButtonIcons(app, 1:4, resize(app.playedCards, 4))
                fprintf("It is Player %g's turn! The last played cards were %g \n", app.playerTurn, app.playedCards)

        else 
                error("Cannot activate player-turn-lock since game is not online \n")
            end
        end


        %% ThingSpeak        
        function [] = UpdateThingSpeak(app)
            fprintf(" ---> UpdatingThingSpeak ... ")
            pause(app.duration)

            data1 = app.lobbyState;
            data2 = string(num2str(app.gameDeck));
            data3 = string(num2str(app.playedCards));
            data4 = app.turnCount;
            data5 = app.skipCount;

            thingSpeakWrite(app.channelID, 'WriteKey', app.writeKey, 'Fields', 1:5, 'Values', [data1, data2, data3, data4, data5]);
            fprintf("All ThingSpeak fields have been updated! <--- \n")
        end

        function output = ReadArray(app, fieldNum)
            dataOut = thingSpeakRead(app.channelID, 'ReadKey', app.readKey, 'Fields', fieldNum, 'OutputFormat', 'Table');
            % disp(dataOut)
            indexedOutput = dataOut{1, 2};
            % fprintf(" ---> Field %g has been read and has value type = ", fieldNum)
            % disp(indexedOutput)

            if iscell(indexedOutput)
                % fprintf("cell")
                output = str2num(cell2mat(indexedOutput));
            elseif isnan(indexedOutput)
                fprintf("NaN")
                % output = 0;  
            elseif isstring(indexedOutput)
                % fprintf("str")
                output = str2num(indexedOutput);
            elseif isa(indexedOutput, "double")
                % fprintf("double")
                output = indexedOutput;
            else 
                error("unexpected. Failed to convert")              
            end
            % fprintf(" <--- \n")
        end

        %% Cards
        function [] = DecodeDeck(app)   % Take full array of cards and break up between players
            app.playerDecks = zeros(app.numPlayers, 13);
            for i = 1:app.numPlayers
                buttonNum = (i*100) + (1:13);
                app.playerDecks(i, :) = app.gameDeck((13*i - 12): 13*i);
                
                UpdateButtonIcons(app, buttonNum, app.playerDecks(i,:));
                UpdateButtonVisible(app, buttonNum, "on")
                buttonsOff = 100*i + find(app.playerDecks(i,:) == 0);
                UpdateButtonVisible(app, buttonsOff, "off")
                UpdateButtonValue(app, buttonsOff, 0)
            end
            fprintf("The following decks have been created: \n")
            disp(app.playerDecks)
        end
        
        function [] = background(app)
            
            file_path = 'crying.mp3';
            [y,Fs] = audioread(file_path);
            audioDampener = .4;
            background = audioplayer(y*audioDampener,Fs)
           
            play(background);
        end
        
        function [] = cardSound(app)
            
            file_path = 'Card_dealt.mp3';
            [y,Fs] = audioread(file_path);
            audioApp = 2.5;
            dealt = audioplayer(y*audioApp,Fs)
            play(dealt);    
        
            
        end
        
        function [] = victorySound(app)
            file_path = 'ff7.mp3';
            [y,Fs] = audioread(file_path);
            audioApp = 1.5;
            win = audioplayer(y*audioApp,Fs)
            play(win);
            
        end
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            
            fprintf("\nA new session of the game has been started! \n")
            
            app.UIFigure.WindowState = 'maximized';
            app.RulesButton.Visible = "on";
            app.Player1Label.Visible = "off";
            app.Player2Label.Visible = "off";
            app.Player3Label.Visible = "off";
            app.Player4Label.Visible = "off";
            app.Label.Visible = "off";
            app.WhosUpPlayerLabel.Visible = "off";
            app.PlayCardsButton.Visible = "off";
            app.SkipTurnButton.Visible = "off";
            app.WhosUpBox.Visible = "off";
            app.Player3Box.Visible = "off";
            app.Player1Box.Visible = "off";
            app.PresidentTitle.Visible = "on";
            app.WhosUpPlayerLabel.Visible ="off";
            app.Player4Box.Visible = "off";
            app.Player2Box.Visible = "off";
            app.HomeButton.Visible = "off";
            app.HowManyPlayersEditField.Visible= "off";
            app.HowManyPlayersEditFieldLabel.Visible = "off";
            app.YourPlayerNumberEditField.Visible= "off";
            app.YourPlayerNumberEditFieldLabel.Visible = "off";
            app.ConfirmButton.Visible ="off";
            app.ResetLobbyButton.Visible = "off";
            UpdateButtonVisible(app, [1:4, 101:113, 201:213, 301:313, 401:413], "off")
            app.MessageLabel.Visible = "off";
            app.SuccessDisplay.Visible = "off";
            app.ErrorDisplay.Visible = "off";
            app.Fireworks.Visible = "off";
            app.LeftLuigi.Visible = "off";
            app.RightLuigi.Visible = "off";
            app.Congrats.Visible = "off";
            background(app)

        end

        % Button pushed function: RulesButton
        function RulesButtonPushed(app, event)
            RulesPopup(app);
            
        end

        % Button pushed function: PlayButton
        function PlayButtonPushed(app, event)
            fprintf("Local game selected. Waiting for number of players... \n")
            app.isOnline = false;

            drawnow;
            app.PlayButton.Visible = "off";
            app.JoinGameButton.Visible = "off";
            app.HowManyPlayersEditField.Visible ="on";
            app.HowManyPlayersEditFieldLabel.Visible = "on";
            app.ConfirmButton.Visible ="on";

        end

        % Button pushed function: JoinGameButton
        function JoinGameButtonPushed(app, event)
            fprintf("Online game intialized! Waiting for player information... \n")
            app.isOnline = true;
            
            %% Update UI
            % drawnow
            app.PlayButton.Visible = "off";
            app.JoinGameButton.Visible = "off";
            app.HowManyPlayersEditField.Visible ="on";
            app.HowManyPlayersEditFieldLabel.Visible = "on";
            app.ConfirmButton.Visible ="on";
            app.ResetLobbyButton.Visible = "on";
            app.YourPlayerNumberEditField.Visible= "on";
            app.YourPlayerNumberEditFieldLabel.Visible = "on";
        end

        % Button pushed function: ResetLobbyButton
        function ResetLobbyButtonPushed(app, event)
            fprintf("Reseting lobby and ThingSpeak...\n")
            app.lobbyState = false;
            app.gameDeck = 0;
            app.playedCards = 0;
            app.turnCount = 1;
            app.skipCount = 0;
            UpdateThingSpeak(app)
        end

        % Button pushed function: ConfirmButton
        function ConfirmButtonPushed(app, event)
            % Check if the game is happening online or local
            if app.isOnline
                %% Online Version
                app.playerID = app.YourPlayerNumberEditField.Value;
                app.lobbyState = ReadArray(app, 1);
                fprintf("The current state of the lobby: %g \n", app.lobbyState)
                
                % Generate deck and send if no current lobby
                if ~app.lobbyState                
                    fprintf("You (Player %g) have opened a new lobby! Variables updated and deck generated. Sending to ThingSpeak... \n", app.playerID)
                    app.lobbyState = true;
                    app.numPlayers = app.HowManyPlayersEditField.Value;
                    app.gameDeck = randperm(52);
                    UpdateThingSpeak(app)

                else % join exisiting lobby
                    if app.playerID <=4
                        fprintf("Sucessfully joined lobby! Grabbing deck data... \n")
                        app.gameDeck = ReadArray(app, 2);
                    else
                         fprintf("Player number not supported \n")
                         return
                    end
                end
                
                DecodeDeck(app)
                changeScene = true;
                
            else
                %% Local Version
                % Game Initialization 
                app.numPlayers = app.HowManyPlayersEditField.Value;
                
                %How many players are there?
                if (app.numPlayers >= 2) && (app.numPlayers <= 4)
                    fprintf("Number of players accepted! \n")

                    % Generate Card Decks
                    app.gameDeck = randperm(52);
                    DecodeDeck(app)
                    changeScene = true;                    
                else
                    fprintf("Number of players not supported \n")
                end
            end

            %% Update Screen
            if changeScene
                app.RulesButton.Visible = "on";
                app.Label.Visible = "on";
                app.WhosUpPlayerLabel.Visible = "on";
                app.PlayCardsButton.Visible = "on";
                app.SkipTurnButton.Visible = "on";
                app.WhosUpBox.Visible = "on";
                app.PresidentTitle.Visible = "on"; %% keep president image up
                app.PlayButton.Visible = "off";
                app.JoinGameButton.Visible = "off";
                app.HowManyPlayersEditField.Visible ="off";
                app.HowManyPlayersEditFieldLabel.Visible = "off";
                app.ConfirmButton.Visible ="off";
                app.SuccessDisplay.Visible ="on";
                app.ResetLobbyButton.Visible = "off";
                app.YourPlayerNumberEditField.Visible= "off";
                app.YourPlayerNumberEditFieldLabel.Visible = "off";
                UpdateButtonVisible(app, 1:4, "on")
                UpdateButtonIcons(app, 1:4, resize(app.playedCards, [1,4]))
                
                % Show cards for number of players
                switch app.HowManyPlayersEditField.Value
                    case 2
                        app.Player1Label.Visible = "on";
                        app.Player2Label.Visible = "on";
                        app.Player3Label.Visible = "off";
                        app.Player4Label.Visible = "off";
                        app.Player1Box.Visible = "on";
                        app.Player2Box.Visible = "on";
                        app.Player3Box.Visible = "off";
                        app.Player4Box.Visible = "off";
                    case 3
                        app.Player1Label.Visible = "on";
                        app.Player2Label.Visible = "on";
                        app.Player3Label.Visible = "on";
                        app.Player4Label.Visible = "off";
                        app.Player1Box.Visible = "on";
                        app.Player2Box.Visible = "on";
                        app.Player3Box.Visible = "on";
                        app.Player4Box.Visible = "off";
                    case 4
                        app.Player1Label.Visible = "on";
                        app.Player2Label.Visible = "on";
                        app.Player3Label.Visible = "on";
                        app.Player4Label.Visible = "on";
                        app.Player1Box.Visible = "on";
                        app.Player2Box.Visible = "on";
                        app.Player3Box.Visible = "on";
                        app.Player4Box.Visible = "on";
                end
            end

            if app.isOnline
                CheckPlayerTurn(app)
                PlayerTurnLock(app)
            end
        end

        % Button pushed function: PlayCardsButton
        function PlayCardsButtonPushed(app, event)
            %% Initalization
            fprintf("The current player turn is: %g \n", app.playerTurn);
            
            if app.isOnline
                app.gameDeck = ReadArray(app, 2);
                DecodeDeck(app)
            end
            
            % Check button states and make array
            buttonStates = CheckButtonStates(app, app.playerTurn*100 + (1:13));
            selectedCards = app.playerDecks(app.playerTurn,buttonStates);           
            
            % Define values to be used for rest of function
            selectedSetSize = length(selectedCards);
            selectedCardValue = mod(selectedCards, 13);
            selectedCardValue(selectedCardValue == 0) = 13;

            playedSetSize = length(app.playedCards);
            playedCardValue = mod(app.playedCards, 13);
            playedCardValue(playedCardValue == 0) = 13;
            
            %% Unsucsessful Turn Logic
            % Have card(s) be selected
            if isempty(selectedCards)
                fprintf("Please select at least one card \n")
                app.ErrorDisplay.Visible = "on";
                app.MessageLabel.Visible = "on";
                errorMessageMatch = "Play anything lol";
                app.MessageLabel.Text = errorMessageMatch;
                pause(1);
                app.MessageLabel.Visible ="off";
                app.ErrorDisplay.Visible = "off";
                return
            end

            % Check if cards played are of matching value
            if selectedSetSize > 1
                for i = 1:(selectedSetSize - 1)
                    if not(selectedCardValue(i) == selectedCardValue(i+1))
                        fprintf("Cards %g are not of matching value \n", selectedCards)
                        app.ErrorDisplay.Visible = "on";
                        app.MessageLabel.Visible = "on";
                        errorMessageMatch = "Error, try again.";
                        app.MessageLabel.Text = errorMessageMatch;
                        pause(3);
                        app.MessageLabel.Visible ="off";
                        app.ErrorDisplay.Visible = "off";
                        return
                    end
                end
            end
            
            % Check if number of cards played matches previous play
            if any(app.playedCards) && not(selectedSetSize == playedSetSize)
               disp(selectedSetSize);
               fprintf("The deck of %g does not match the size of the previous play %g \n", selectedCards, app.playedCards)
               app.ErrorDisplay.Visible = "on";
                app.MessageLabel.Visible = "on";
                errorMessageMatch = "Match the amount.";
                app.MessageLabel.Text = errorMessageMatch;
                pause(3);
                app.MessageLabel.Visible ="off";
                app.ErrorDisplay.Visible = "off";
               return
            end
            
            %% Turn Was Sucessful
            %Check if cards played are higher value
            if (selectedCardValue(1) > playedCardValue(1)) || ~any(app.playedCards)
                app.playedCards = selectedCards;
                fprintf("Cards %g played sucessfully! \n", app.playedCards)

                app.SuccessDisplay.Visible = "on";
                successMessage = "Succesful move";
                app.MessageLabel.Visible = "on";
                app.MessageLabel.Text = successMessage;
                % pause(3)
                % app.MessageLabel.Visible = "off";
                % app.MessageLabel.Visible = "on";

                disp(app.playerDecks);

                %% Kill cards from deck
                position = zeros(1,playedSetSize);
                for i = 1:selectedSetSize
                    position(i) = find(app.playerDecks == app.playedCards(i));
                end
                app.playerDecks(position) = 0;

                app.gameDeck = zeros(1,app.numPlayers*13);
                for i = 1:app.numPlayers
                    app.gameDeck((13*i - 12): 13*i) = horzcat(app.playerDecks(i,:));
                end
                fprintf("The current decks are: \n")
                disp(app.playerDecks);

                %% Make Button Disapear
                buttonsOff = app.playerTurn*100 + find(app.playerDecks(app.playerTurn, :) == 0);
                UpdateButtonVisible(app, buttonsOff, "off")
                UpdateButtonValue(app, buttonsOff, 0)
                cardSound(app)

                % Set Center Buttons
                UpdateButtonIcons(app, 1:4, resize(app.playedCards, 4))
                IncreasePlayerTurn(app);

                %% Check Winstate
                for i = 1:app.numPlayers
                    playersHand = app.playerDecks(i,:); %isolates one player's hand
                    summedHand = sum(playersHand); %sums all the values of that players hand

                    if summedHand == 0  %Checks if hand sums to 0, meaning the hand is empty
                        app.gameState = "Round Complete";
                        fprintf("Player %g has won! \n", i)
                        app.winPlayer = i;
                        UpdateButtonVisible(app, [1:4, 101:113, 201:213,301:313,401:413], "off")
                        app.HomeButton.Visible = "on";
                        app.Player1Label.Visible = "off";
                        app.Player2Label.Visible = "off";
                        app.Player3Label.Visible = "off";
                        app.Player4Label.Visible = "off";
                        app.Player1Label.Visible = "off";
                        app.Player2Label.Visible = "off";
                        app.Player3Label.Visible = "off";
                        app.Player4Label.Visible = "off";
                        app.Label.Visible = "off";
                        app.WhosUpBox.Visible = "off";
                        app.WhosUpPlayerLabel.Visible = "off";
                        app.PlayCardsButton.Visible = "off";
                        app.SkipTurnButton.Visible = "off";
                        app.SuccessDisplay.Visible = "off";
                        app.Player1Box.Visible ="off";
                        app.Player2Box.Visible ="off";
                        app.Player3Box.Visible ="off";
                        app.Player4Box.Visible ="off";
                        
                        clear sound 
                        victorySound(app)
                        app.Fireworks.Visible = "on";
                        app.LeftLuigi.Visible = "on";
                        app.RightLuigi.Visible = "on";
                        app.Congrats.Visible = "on";

                        
                        break
                    else 
                        app.gameState = "Round Incomplete";
                        fprintf("Player %g has still not won \n", i)
                        app.winPlayer = 0 ;
                    end 
                end 

                % Send to ThingSpeak
                if app.isOnline
                    UpdateThingSpeak(app)
                    PlayerTurnLock(app)
                end
            else
                fprintf("The current value on the table is %g \n", playedCardValue)
                fprintf("Value of cards %g ia not high enough \n", selectedCardValue)

                errorValue = "Value of card(s) too low.";
                app.MessageLabel.Visible = "on";
                app.ErrorDisplay.Visible ="on";
                app.MessageLabel.Text = errorValue;
                pause(3)
                app.MessageLabel.Visible = "off";
                app.ErrorDisplay.Visible = "off";
       
            end
        end

        % Button pushed function: SkipTurnButton
        function SkipTurnButtonPushed(app, event)
            fprintf("Player %g's turn has been skipped \n", app.playerTurn)
            %Increase skip Count
            if app.isOnline
                app.skipCount = ReadArray(app, 5);
            end
            app.skipCount = app.skipCount + 1;
            % test = app.numPlayers;
            % test2 = string(test);
            % app.Label.Text = test2;

            %Check if all players have skip, initialize new round, set next playerTurn
            if app.skipCount == app.numPlayers - 1
                roundWinner = mod(app.turnCount, app.numPlayers) + 1; 
                app.skipCount = 0;
                app.playedCards = 0;
                UpdateButtonIcons(app, 1:4, resize(app.playedCards, [1,4]))
                fprintf("Player %g has won the round! \n", roundWinner);
                app.SuccessDisplay.Visible = "on";
                app.MessageLabel.Visible = "on";

                winMessageMatch = "Player "+ roundWinner +" has won the round.";
                app.MessageLabel.Text = winMessageMatch;
                pause(3);
                app.MessageLabel.Visible ="off";
                app.SuccessDisplay.Visible = "on";
            end
            

            %Increase Player Turn     
            IncreasePlayerTurn(app)
            
            if app.isOnline
                UpdateThingSpeak(app)
                PlayerTurnLock(app)
            end
        end

        % Button pushed function: HomeButton
        function HomeButtonPushed(app, event)
            app.RulesButton.Visible = "on";
            app.Player1Label.Visible = "off";
            app.Player2Label.Visible = "off";
            app.Player3Label.Visible = "off";
            app.Player4Label.Visible = "off";
            app.Label.Visible = "off";
            app.WhosUpPlayerLabel.Visible = "off";
            app.PlayCardsButton.Visible = "off";
            app.SkipTurnButton.Visible = "off";
            app.WhosUpBox.Visible = "off";
            app.Player3Box.Visible = "off";
            app.Player1Box.Visible = "off";
            app.PresidentTitle.Visible = "on";
            app.Player4Box.Visible = "off";
            app.Player2Box.Visible = "off";
            app.HomeButton.Visible = "off";
            background(app)
            app.PlayButton.Visible="on";
            app.JoinGameButton.Visible="on";

        end

        % Close request function: UIFigure
        function UIFigureCloseRequest(app, event)
            delete(app)
            clear sound; 
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.0392 0.651 0.251];
            app.UIFigure.Position = [100.2 100.2 1199 627];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Create Player2Box
            app.Player2Box = uiimage(app.UIFigure);
            app.Player2Box.ScaleMethod = 'stretch';
            app.Player2Box.Position = [-16 50 714 531];
            app.Player2Box.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'background.png');

            % Create Player4Box
            app.Player4Box = uiimage(app.UIFigure);
            app.Player4Box.Position = [742 47 714 531];
            app.Player4Box.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'background.png');

            % Create Player1Box
            app.Player1Box = uiimage(app.UIFigure);
            app.Player1Box.Position = [154 -287 714 531];
            app.Player1Box.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'background.png');

            % Create Player3Box
            app.Player3Box = uiimage(app.UIFigure);
            app.Player3Box.Position = [92 57 714 531];
            app.Player3Box.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'background.png');

            % Create PresidentTitle
            app.PresidentTitle = uiimage(app.UIFigure);
            app.PresidentTitle.Position = [10 270 714 531];
            app.PresidentTitle.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'President Title.png');

            % Create SkipTurnButton
            app.SkipTurnButton = uibutton(app.UIFigure, 'push');
            app.SkipTurnButton.ButtonPushedFcn = createCallbackFcn(app, @SkipTurnButtonPushed, true);
            app.SkipTurnButton.BackgroundColor = [0.9804 0.4314 0.4314];
            app.SkipTurnButton.FontName = 'Modern No. 20';
            app.SkipTurnButton.FontSize = 18;
            app.SkipTurnButton.Position = [282 228 100 30];
            app.SkipTurnButton.Text = 'Skip Turn';

            % Create PlayCardsButton
            app.PlayCardsButton = uibutton(app.UIFigure, 'push');
            app.PlayCardsButton.ButtonPushedFcn = createCallbackFcn(app, @PlayCardsButtonPushed, true);
            app.PlayCardsButton.BackgroundColor = [0.4706 0.8706 0.4706];
            app.PlayCardsButton.FontName = 'Modern No. 20';
            app.PlayCardsButton.FontSize = 18;
            app.PlayCardsButton.Position = [172 228 100 30];
            app.PlayCardsButton.Text = 'Play Cards';

            % Create Player4Label
            app.Player4Label = uilabel(app.UIFigure);
            app.Player4Label.FontName = 'Modern No. 20';
            app.Player4Label.FontSize = 18;
            app.Player4Label.Position = [772 525 66 23];
            app.Player4Label.Text = 'Player 4';

            % Create Player2Label
            app.Player2Label = uilabel(app.UIFigure);
            app.Player2Label.FontName = 'Modern No. 20';
            app.Player2Label.FontSize = 18;
            app.Player2Label.Position = [12 531 66 23];
            app.Player2Label.Text = 'Player 2';

            % Create Player1Label
            app.Player1Label = uilabel(app.UIFigure);
            app.Player1Label.FontName = 'Modern No. 20';
            app.Player1Label.FontSize = 18;
            app.Player1Label.Position = [183 195 66 23];
            app.Player1Label.Text = 'Player 1';

            % Create Player3Label
            app.Player3Label = uilabel(app.UIFigure);
            app.Player3Label.FontName = 'Modern No. 20';
            app.Player3Label.FontSize = 18;
            app.Player3Label.Position = [122 535 66 23];
            app.Player3Label.Text = 'Player 3';

            % Create RulesButton
            app.RulesButton = uibutton(app.UIFigure, 'push');
            app.RulesButton.ButtonPushedFcn = createCallbackFcn(app, @RulesButtonPushed, true);
            app.RulesButton.BackgroundColor = [1 0.502 1];
            app.RulesButton.FontName = 'Modern No. 20';
            app.RulesButton.FontSize = 24;
            app.RulesButton.Position = [12 581 100 38];
            app.RulesButton.Text = 'Rules';

            % Create PlayButton
            app.PlayButton = uibutton(app.UIFigure, 'push');
            app.PlayButton.ButtonPushedFcn = createCallbackFcn(app, @PlayButtonPushed, true);
            app.PlayButton.BackgroundColor = [0.4706 0.8706 0.4706];
            app.PlayButton.FontName = 'Modern No. 20';
            app.PlayButton.FontSize = 36;
            app.PlayButton.Position = [246 328 163 92];
            app.PlayButton.Text = 'Play';

            % Create JoinGameButton
            app.JoinGameButton = uibutton(app.UIFigure, 'push');
            app.JoinGameButton.ButtonPushedFcn = createCallbackFcn(app, @JoinGameButtonPushed, true);
            app.JoinGameButton.BackgroundColor = [0.4706 0.8706 0.4706];
            app.JoinGameButton.FontName = 'Modern No. 20';
            app.JoinGameButton.FontSize = 36;
            app.JoinGameButton.Position = [447 329 170 92];
            app.JoinGameButton.Text = 'Join Game';

            % Create HomeButton
            app.HomeButton = uibutton(app.UIFigure, 'push');
            app.HomeButton.ButtonPushedFcn = createCallbackFcn(app, @HomeButtonPushed, true);
            app.HomeButton.BackgroundColor = [0.4706 0.8706 0.4706];
            app.HomeButton.FontName = 'Modern No. 20';
            app.HomeButton.FontSize = 48;
            app.HomeButton.Position = [216 341 209 69];
            app.HomeButton.Text = 'Home';

            % Create HowManyPlayersEditFieldLabel
            app.HowManyPlayersEditFieldLabel = uilabel(app.UIFigure);
            app.HowManyPlayersEditFieldLabel.BackgroundColor = [0.4706 0.8706 0.4706];
            app.HowManyPlayersEditFieldLabel.HorizontalAlignment = 'right';
            app.HowManyPlayersEditFieldLabel.FontName = 'Modern No. 20';
            app.HowManyPlayersEditFieldLabel.FontSize = 20;
            app.HowManyPlayersEditFieldLabel.Position = [142 369 168 26];
            app.HowManyPlayersEditFieldLabel.Text = 'How Many Players?';

            % Create HowManyPlayersEditField
            app.HowManyPlayersEditField = uieditfield(app.UIFigure, 'numeric');
            app.HowManyPlayersEditField.FontName = 'Modern No. 20';
            app.HowManyPlayersEditField.FontSize = 20;
            app.HowManyPlayersEditField.BackgroundColor = [0.4706 0.8706 0.4706];
            app.HowManyPlayersEditField.Position = [325 368 100 27];
            app.HowManyPlayersEditField.Value = 2;

            % Create ConfirmButton
            app.ConfirmButton = uibutton(app.UIFigure, 'push');
            app.ConfirmButton.ButtonPushedFcn = createCallbackFcn(app, @ConfirmButtonPushed, true);
            app.ConfirmButton.BackgroundColor = [0.4706 0.8706 0.4706];
            app.ConfirmButton.FontName = 'Modern No. 20';
            app.ConfirmButton.FontSize = 18;
            app.ConfirmButton.Position = [208 264 207 59];
            app.ConfirmButton.Text = 'Confirm';

            % Create WhosUpBox
            app.WhosUpBox = uiimage(app.UIFigure);
            app.WhosUpBox.Position = [322 260 183 158];
            app.WhosUpBox.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'background bigger.png');

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.HorizontalAlignment = 'center';
            app.Label.FontName = 'Modern No. 20';
            app.Label.FontSize = 24;
            app.Label.Position = [354 287 155 62];
            app.Label.Text = '1';

            % Create WhosUpPlayerLabel
            app.WhosUpPlayerLabel = uilabel(app.UIFigure);
            app.WhosUpPlayerLabel.FontName = 'Modern No. 20';
            app.WhosUpPlayerLabel.FontSize = 24;
            app.WhosUpPlayerLabel.Position = [357 302 106 62];
            app.WhosUpPlayerLabel.Text = {'Who''s Up:'; 'Player'};

            % Create Button_101
            app.Button_101 = uibutton(app.UIFigure, 'state');
            app.Button_101.Text = '';
            app.Button_101.Position = [117 44 94 133];

            % Create Button_102
            app.Button_102 = uibutton(app.UIFigure, 'state');
            app.Button_102.Text = '';
            app.Button_102.Position = [164 44 94 133];

            % Create Button_103
            app.Button_103 = uibutton(app.UIFigure, 'state');
            app.Button_103.Text = '';
            app.Button_103.Position = [192 44 94 133];

            % Create Button_104
            app.Button_104 = uibutton(app.UIFigure, 'state');
            app.Button_104.Text = '';
            app.Button_104.Position = [229 44 94 133];

            % Create Button_105
            app.Button_105 = uibutton(app.UIFigure, 'state');
            app.Button_105.Text = '';
            app.Button_105.Position = [264 44 94 133];

            % Create Button_106
            app.Button_106 = uibutton(app.UIFigure, 'state');
            app.Button_106.Text = '';
            app.Button_106.Position = [302 44 94 133];

            % Create Button_107
            app.Button_107 = uibutton(app.UIFigure, 'state');
            app.Button_107.Text = '';
            app.Button_107.Position = [338 44 94 133];

            % Create Button_108
            app.Button_108 = uibutton(app.UIFigure, 'state');
            app.Button_108.Text = '';
            app.Button_108.Position = [377 44 94 133];

            % Create Button_109
            app.Button_109 = uibutton(app.UIFigure, 'state');
            app.Button_109.Text = '';
            app.Button_109.Position = [411 44 94 133];

            % Create Button_110
            app.Button_110 = uibutton(app.UIFigure, 'state');
            app.Button_110.Text = '';
            app.Button_110.Position = [452 44 94 133];

            % Create Button_111
            app.Button_111 = uibutton(app.UIFigure, 'state');
            app.Button_111.Text = '';
            app.Button_111.Position = [492 44 94 133];

            % Create Button_112
            app.Button_112 = uibutton(app.UIFigure, 'state');
            app.Button_112.Text = '';
            app.Button_112.Position = [521 45 94 133];

            % Create Button_113
            app.Button_113 = uibutton(app.UIFigure, 'state');
            app.Button_113.Text = '';
            app.Button_113.Position = [551 45 94 133];

            % Create Button_4
            app.Button_4 = uibutton(app.UIFigure, 'state');
            app.Button_4.Text = '';
            app.Button_4.Position = [216 302 62 88];

            % Create Button_3
            app.Button_3 = uibutton(app.UIFigure, 'state');
            app.Button_3.Text = '';
            app.Button_3.Position = [235 292 62 88];

            % Create Button_2
            app.Button_2 = uibutton(app.UIFigure, 'state');
            app.Button_2.Text = '';
            app.Button_2.Position = [251 280 62 88];

            % Create Button_1
            app.Button_1 = uibutton(app.UIFigure, 'state');
            app.Button_1.Text = '';
            app.Button_1.Position = [271 260 62 88];

            % Create Button_201
            app.Button_201 = uibutton(app.UIFigure, 'state');
            app.Button_201.Text = '';
            app.Button_201.Position = [8 387 94 133];

            % Create Button_202
            app.Button_202 = uibutton(app.UIFigure, 'state');
            app.Button_202.Text = '';
            app.Button_202.Position = [8 355 94 133];

            % Create Button_203
            app.Button_203 = uibutton(app.UIFigure, 'state');
            app.Button_203.Text = '';
            app.Button_203.Position = [8 334 94 133];

            % Create Button_204
            app.Button_204 = uibutton(app.UIFigure, 'state');
            app.Button_204.Text = '';
            app.Button_204.Position = [8 308 94 133];

            % Create Button_205
            app.Button_205 = uibutton(app.UIFigure, 'state');
            app.Button_205.Text = '';
            app.Button_205.Position = [8 278 94 133];

            % Create Button_206
            app.Button_206 = uibutton(app.UIFigure, 'state');
            app.Button_206.Text = '';
            app.Button_206.Position = [8 255 94 133];

            % Create Button_207
            app.Button_207 = uibutton(app.UIFigure, 'state');
            app.Button_207.Text = '';
            app.Button_207.Position = [8 221 94 133];

            % Create Button_208
            app.Button_208 = uibutton(app.UIFigure, 'state');
            app.Button_208.Text = '';
            app.Button_208.Position = [8 195 94 133];

            % Create Button_209
            app.Button_209 = uibutton(app.UIFigure, 'state');
            app.Button_209.Text = '';
            app.Button_209.Position = [8 176 94 133];

            % Create Button_210
            app.Button_210 = uibutton(app.UIFigure, 'state');
            app.Button_210.Text = '';
            app.Button_210.Position = [8 146 94 133];

            % Create Button_211
            app.Button_211 = uibutton(app.UIFigure, 'state');
            app.Button_211.Text = '';
            app.Button_211.Position = [8 123 94 133];

            % Create Button_212
            app.Button_212 = uibutton(app.UIFigure, 'state');
            app.Button_212.Text = '';
            app.Button_212.Position = [8 89 94 133];

            % Create Button_213
            app.Button_213 = uibutton(app.UIFigure, 'state');
            app.Button_213.Text = '';
            app.Button_213.Position = [8 52 94 133];

            % Create Button_301
            app.Button_301 = uibutton(app.UIFigure, 'state');
            app.Button_301.Text = '';
            app.Button_301.Position = [125 394 94 133];

            % Create Button_302
            app.Button_302 = uibutton(app.UIFigure, 'state');
            app.Button_302.Text = '';
            app.Button_302.Position = [163 394 94 133];

            % Create Button_303
            app.Button_303 = uibutton(app.UIFigure, 'state');
            app.Button_303.Text = '';
            app.Button_303.Position = [209 394 94 133];

            % Create Button_304
            app.Button_304 = uibutton(app.UIFigure, 'state');
            app.Button_304.Text = '';
            app.Button_304.Position = [253 394 94 133];

            % Create Button_305
            app.Button_305 = uibutton(app.UIFigure, 'state');
            app.Button_305.Text = '';
            app.Button_305.Position = [298 394 94 133];

            % Create Button_306
            app.Button_306 = uibutton(app.UIFigure, 'state');
            app.Button_306.Text = '';
            app.Button_306.Position = [340 394 94 133];

            % Create Button_307
            app.Button_307 = uibutton(app.UIFigure, 'state');
            app.Button_307.Text = '';
            app.Button_307.Position = [385 394 94 133];

            % Create Button_308
            app.Button_308 = uibutton(app.UIFigure, 'state');
            app.Button_308.Text = '';
            app.Button_308.Position = [426 394 94 133];

            % Create Button_309
            app.Button_309 = uibutton(app.UIFigure, 'state');
            app.Button_309.Text = '';
            app.Button_309.Position = [473 394 94 133];

            % Create Button_310
            app.Button_310 = uibutton(app.UIFigure, 'state');
            app.Button_310.Text = '';
            app.Button_310.Position = [519 394 94 133];

            % Create Button_311
            app.Button_311 = uibutton(app.UIFigure, 'state');
            app.Button_311.Text = '';
            app.Button_311.Position = [561 395 94 133];

            % Create Button_312
            app.Button_312 = uibutton(app.UIFigure, 'state');
            app.Button_312.Text = '';
            app.Button_312.Position = [601 395 94 133];

            % Create Button_313
            app.Button_313 = uibutton(app.UIFigure, 'state');
            app.Button_313.Text = '';
            app.Button_313.Position = [641 395 94 133];

            % Create Button_401
            app.Button_401 = uibutton(app.UIFigure, 'state');
            app.Button_401.Text = '';
            app.Button_401.Position = [761 387 94 133];

            % Create Button_402
            app.Button_402 = uibutton(app.UIFigure, 'state');
            app.Button_402.Text = '';
            app.Button_402.Position = [761 355 94 133];

            % Create Button_403
            app.Button_403 = uibutton(app.UIFigure, 'state');
            app.Button_403.Text = '';
            app.Button_403.Position = [761 334 94 133];

            % Create Button_404
            app.Button_404 = uibutton(app.UIFigure, 'state');
            app.Button_404.Text = '';
            app.Button_404.Position = [761 308 94 133];

            % Create Button_405
            app.Button_405 = uibutton(app.UIFigure, 'state');
            app.Button_405.Text = '';
            app.Button_405.Position = [761 278 94 133];

            % Create Button_406
            app.Button_406 = uibutton(app.UIFigure, 'state');
            app.Button_406.Text = '';
            app.Button_406.Position = [761 255 94 133];

            % Create Button_407
            app.Button_407 = uibutton(app.UIFigure, 'state');
            app.Button_407.Text = '';
            app.Button_407.Position = [761 221 94 133];

            % Create Button_408
            app.Button_408 = uibutton(app.UIFigure, 'state');
            app.Button_408.Text = '';
            app.Button_408.Position = [761 195 94 133];

            % Create Button_409
            app.Button_409 = uibutton(app.UIFigure, 'state');
            app.Button_409.Text = '';
            app.Button_409.Position = [761 176 94 133];

            % Create Button_410
            app.Button_410 = uibutton(app.UIFigure, 'state');
            app.Button_410.Text = '';
            app.Button_410.Position = [761 146 94 133];

            % Create Button_411
            app.Button_411 = uibutton(app.UIFigure, 'state');
            app.Button_411.Text = '';
            app.Button_411.Position = [761 123 94 133];

            % Create Button_412
            app.Button_412 = uibutton(app.UIFigure, 'state');
            app.Button_412.Text = '';
            app.Button_412.Position = [761 89 94 133];

            % Create Button_413
            app.Button_413 = uibutton(app.UIFigure, 'state');
            app.Button_413.Text = '';
            app.Button_413.Position = [761 52 94 133];

            % Create SuccessDisplay
            app.SuccessDisplay = uiimage(app.UIFigure);
            app.SuccessDisplay.Position = [452 188 341 182];
            app.SuccessDisplay.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'success background.png');

            % Create ErrorDisplay
            app.ErrorDisplay = uiimage(app.UIFigure);
            app.ErrorDisplay.Position = [446 188 354 182];
            app.ErrorDisplay.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'error background.png');

            % Create MessageLabel
            app.MessageLabel = uilabel(app.UIFigure);
            app.MessageLabel.HorizontalAlignment = 'center';
            app.MessageLabel.FontName = 'Modern No. 20';
            app.MessageLabel.FontSize = 18;
            app.MessageLabel.Position = [492 238 290 110];
            app.MessageLabel.Text = 'test';

            % Create LeftLuigi
            app.LeftLuigi = uiimage(app.UIFigure);
            app.LeftLuigi.Position = [867 57 100 100];
            app.LeftLuigi.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'LuigiVibin.gif');

            % Create RightLuigi
            app.RightLuigi = uiimage(app.UIFigure);
            app.RightLuigi.Position = [1081 57 100 100];
            app.RightLuigi.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'LuigiVibin.gif');

            % Create Congrats
            app.Congrats = uiimage(app.UIFigure);
            app.Congrats.Position = [821 -32 456 381];
            app.Congrats.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'Congrats!.png');

            % Create Fireworks
            app.Fireworks = uiimage(app.UIFigure);
            app.Fireworks.Position = [837 280 344 338];
            app.Fireworks.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'Fireworks.gif');

            % Create ResetLobbyButton
            app.ResetLobbyButton = uibutton(app.UIFigure, 'push');
            app.ResetLobbyButton.ButtonPushedFcn = createCallbackFcn(app, @ResetLobbyButtonPushed, true);
            app.ResetLobbyButton.BackgroundColor = [0.8706 0.4706 0.4706];
            app.ResetLobbyButton.FontName = 'Modern No. 20';
            app.ResetLobbyButton.FontSize = 18;
            app.ResetLobbyButton.Position = [521 280 207 59];
            app.ResetLobbyButton.Text = 'Reset Lobby';

            % Create YourPlayerNumberEditFieldLabel
            app.YourPlayerNumberEditFieldLabel = uilabel(app.UIFigure);
            app.YourPlayerNumberEditFieldLabel.BackgroundColor = [0.4706 0.8706 0.4706];
            app.YourPlayerNumberEditFieldLabel.HorizontalAlignment = 'right';
            app.YourPlayerNumberEditFieldLabel.FontName = 'Modern No. 20';
            app.YourPlayerNumberEditFieldLabel.FontSize = 20;
            app.YourPlayerNumberEditFieldLabel.Position = [136 334 175 26];
            app.YourPlayerNumberEditFieldLabel.Text = 'Your Player Number';

            % Create YourPlayerNumberEditField
            app.YourPlayerNumberEditField = uieditfield(app.UIFigure, 'numeric');
            app.YourPlayerNumberEditField.FontName = 'Modern No. 20';
            app.YourPlayerNumberEditField.FontSize = 20;
            app.YourPlayerNumberEditField.BackgroundColor = [0.4706 0.8706 0.4706];
            app.YourPlayerNumberEditField.Position = [326 333 100 27];
            app.YourPlayerNumberEditField.Value = 2;

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = PresidentExported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end