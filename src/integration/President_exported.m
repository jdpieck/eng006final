classdef President_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure              matlab.ui.Figure
        JoinGameButton        matlab.ui.control.Button
        PlayButton            matlab.ui.control.Button
        Image2_3              matlab.ui.control.Image
        RulesButton           matlab.ui.control.Button
        Player3Label          matlab.ui.control.Label
        Player1Label          matlab.ui.control.Label
        Player2Label          matlab.ui.control.Label
        Player4Label          matlab.ui.control.Label
        LastHandPlayedxLabel  matlab.ui.control.Label
        WhosUpPlLabel         matlab.ui.control.Label
        PlayCardsButton       matlab.ui.control.Button
        SkipTurnButton        matlab.ui.control.Button
        Image6                matlab.ui.control.Image
        Image2_5              matlab.ui.control.Image
        Image2_4              matlab.ui.control.Image
        Image2_2              matlab.ui.control.Image
        Image2                matlab.ui.control.Image
    end

    
    properties (Access = public)
        cards               %Array of all 52 Cards
        numPlayers = 4          % number of player
        playerTurn          % Current Player
        playerDecks        % MxN array with M = # of players & N = number of cards
        playedCards         % Cards on the table
        selectedCards       % Cards selected to be played

        playedSetSize
        selectedSetSize
        selectedCardValue
        playedCardValue
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            drawnow;
            app.UIFigure.WindowState = 'maximized';
            app.RulesButton.Visible = "on";
            app.Player1Label.Visible = "off";
            app.Player2Label.Visible = "off";
            app.Player3Label.Visible = "off";
            app.Player4Label.Visible = "off";
            app.LastHandPlayedxLabel.Visible = "off";
            app.WhosUpPlLabel.Visible = "off";
            app.PlayCardsButton.Visible = "off";
            app.SkipTurnButton.Visible = "off";
            app.Image6.Visible = "off";
            app.Image2_5.Visible = "off";
            app.Image2_4.Visible = "off";
            app.Image2_3.Visible = "on";
            app.Image2_2.Visible = "off";
            app.Image2.Visible = "off";


        end

        % Button pushed function: RulesButton
        function RulesButtonPushed(app, event)
            RulesPopup
            % Card_dealt = 'victory.mp3';
            % audiowrite(Card_dealt,y,Fs)
            % clear y Fs app
            % [y,Fs] = audioread('victory.mp3')
        end

        % Button pushed function: PlayButton
        function PlayButtonPushed(app, event)
            drawnow;
            app.UIFigure.WindowState = 'maximized';
            app.RulesButton.Visible = "on";
            app.Player1Label.Visible = "on";
            app.Player2Label.Visible = "on";
            app.Player3Label.Visible = "on";
            app.Player4Label.Visible = "on";
            app.LastHandPlayedxLabel.Visible = "on";
            app.WhosUpPlLabel.Visible = "on";
            app.PlayCardsButton.Visible = "on";
            app.SkipTurnButton.Visible = "on";
            app.Image6.Visible = "on";
            app.Image2_5.Visible = "on";
            app.Image2_4.Visible = "on";
            app.Image2_3.Visible = "on";
            app.Image2_2.Visible = "on";
            app.Image2.Visible = "on";
            app.PlayButton.Visible = "off";
            app.JoinGameButton.Visible = "off";

            %Create random order of 52 unique cards
            app.cards = randperm(52); 
            
            %How many players are there?
            if (app.numPlayers >= 2) && (app.numPlayers <= 4)
                app.playerDecks = zeros(app.numPlayers, 13);
                for i = 1:app.numPlayers
                    app.playerDecks(i, :) = app.cards((13*i - 12): 13*i);
                    fprintf("A deck as been created! \n")
                end
            else
                fprintf("Number of players not supported \n")
            end             
        end

        % Button pushed function: PlayCardsButton
        function PlayCardsButtonPushed(app, event)
            app.playedSetSize = length(app.playedCards);
            app.selectedSetSize = length(app.selectedCards);
            app.selectedCardValue = mod(app.selectedCards, 13);
            app.playedCardValue = mod(app.lastCardsPlayed, 13);


            %Check if cards played are of matching value
            if app.selectedSetSize > 1
                for i = 1:(app.selectedSetSize - 1)
                    if not(app.selectedCardValue(i) == app.selectedCardValue(i+1))
                        fprintf("Cards are not of matching value \n")
                        return
                    end
                end
            end
        
            %Check if first player
            if isempty(app.playedCards)
                app.playedCards = app.selectedCards;
                fprintf("Cards played sucessfully! \n")
                return
        
            end
            
            %Check if number of cards played matches previous play
            if not(app.selectedSetSize == app.playedSetSize)
               fprintf("Does not match set size \n")
               return
            end
            
            %Check if cards played are higher value
            if app.selectedCardValue(1) > app.playedCardValue(1)
                app.playedCards = app.selectedCards;
                fprintf("Cards played sucessfully! \n")
            else
                fprintf("Value of cards not high enough \n")
            end
        end

        % Button pushed function: SkipTurnButton
        function SkipTurnButtonPushed(app, event)

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
            app.UIFigure.Color = [0.4667 0.6745 0.1882];
            app.UIFigure.Position = [100.2 100.2 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create Image2
            app.Image2 = uiimage(app.UIFigure);
            app.Image2.ScaleMethod = 'stretch';
            app.Image2.Position = [-16 -205 714 531];
            app.Image2.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'background.png');

            % Create Image2_2
            app.Image2_2 = uiimage(app.UIFigure);
            app.Image2_2.Position = [547 -205 714 531];
            app.Image2_2.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'background.png');

            % Create Image2_4
            app.Image2_4 = uiimage(app.UIFigure);
            app.Image2_4.Position = [154 -407 714 531];
            app.Image2_4.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'background.png');

            % Create Image2_5
            app.Image2_5 = uiimage(app.UIFigure);
            app.Image2_5.Position = [154 -31 714 531];
            app.Image2_5.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'background.png');

            % Create Image6
            app.Image6 = uiimage(app.UIFigure);
            app.Image6.Position = [54 72 247 313];
            app.Image6.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'background bigger.png');

            % Create SkipTurnButton
            app.SkipTurnButton = uibutton(app.UIFigure, 'push');
            app.SkipTurnButton.ButtonPushedFcn = createCallbackFcn(app, @SkipTurnButtonPushed, true);
            app.SkipTurnButton.BackgroundColor = [1 0 0];
            app.SkipTurnButton.FontName = 'Modern No. 20';
            app.SkipTurnButton.FontSize = 18;
            app.SkipTurnButton.Position = [382 123 100 30];
            app.SkipTurnButton.Text = 'Skip Turn';

            % Create PlayCardsButton
            app.PlayCardsButton = uibutton(app.UIFigure, 'push');
            app.PlayCardsButton.ButtonPushedFcn = createCallbackFcn(app, @PlayCardsButtonPushed, true);
            app.PlayCardsButton.BackgroundColor = [0 1 0];
            app.PlayCardsButton.FontName = 'Modern No. 20';
            app.PlayCardsButton.FontSize = 18;
            app.PlayCardsButton.Position = [164 123 100 30];
            app.PlayCardsButton.Text = 'Play Cards';

            % Create WhosUpPlLabel
            app.WhosUpPlLabel = uilabel(app.UIFigure);
            app.WhosUpPlLabel.HorizontalAlignment = 'center';
            app.WhosUpPlLabel.FontName = 'Modern No. 20';
            app.WhosUpPlLabel.FontSize = 24;
            app.WhosUpPlLabel.Position = [127 141 108 90];
            app.WhosUpPlLabel.Text = {'Who''s Up:'; 'Pl'};

            % Create LastHandPlayedxLabel
            app.LastHandPlayedxLabel = uilabel(app.UIFigure);
            app.LastHandPlayedxLabel.HorizontalAlignment = 'center';
            app.LastHandPlayedxLabel.FontName = 'Modern No. 20';
            app.LastHandPlayedxLabel.FontSize = 24;
            app.LastHandPlayedxLabel.Position = [88 208 187 90];
            app.LastHandPlayedxLabel.Text = {'Last Hand Played:'; 'x'};

            % Create Player4Label
            app.Player4Label = uilabel(app.UIFigure);
            app.Player4Label.FontName = 'Modern No. 20';
            app.Player4Label.FontSize = 18;
            app.Player4Label.Position = [575 275 66 23];
            app.Player4Label.Text = 'Player 4';

            % Create Player2Label
            app.Player2Label = uilabel(app.UIFigure);
            app.Player2Label.FontName = 'Modern No. 20';
            app.Player2Label.FontSize = 18;
            app.Player2Label.Position = [12 275 66 23];
            app.Player2Label.Text = 'Player 2';

            % Create Player1Label
            app.Player1Label = uilabel(app.UIFigure);
            app.Player1Label.FontName = 'Modern No. 20';
            app.Player1Label.FontSize = 18;
            app.Player1Label.Position = [181 72 66 23];
            app.Player1Label.Text = 'Player 1';

            % Create Player3Label
            app.Player3Label = uilabel(app.UIFigure);
            app.Player3Label.FontName = 'Modern No. 20';
            app.Player3Label.FontSize = 18;
            app.Player3Label.Position = [181 449 66 23];
            app.Player3Label.Text = 'Player 3';

            % Create RulesButton
            app.RulesButton = uibutton(app.UIFigure, 'push');
            app.RulesButton.ButtonPushedFcn = createCallbackFcn(app, @RulesButtonPushed, true);
            app.RulesButton.BackgroundColor = [0.7176 0.2745 1];
            app.RulesButton.FontName = 'Modern No. 20';
            app.RulesButton.FontSize = 24;
            app.RulesButton.Position = [12 434 100 38];
            app.RulesButton.Text = 'Rules';

            % Create Image2_3
            app.Image2_3 = uiimage(app.UIFigure);
            app.Image2_3.Position = [-36 40 714 531];
            app.Image2_3.ImageSource = fullfile(pathToMLAPP, 'imagescrying', 'President Title.png');

            % Create PlayButton
            app.PlayButton = uibutton(app.UIFigure, 'push');
            app.PlayButton.ButtonPushedFcn = createCallbackFcn(app, @PlayButtonPushed, true);
            app.PlayButton.BackgroundColor = [0 1 0];
            app.PlayButton.FontName = 'Modern No. 20';
            app.PlayButton.FontSize = 36;
            app.PlayButton.Position = [132 182 163 92];
            app.PlayButton.Text = 'Play';

            % Create JoinGameButton
            app.JoinGameButton = uibutton(app.UIFigure, 'push');
            app.JoinGameButton.BackgroundColor = [0 1 0];
            app.JoinGameButton.FontName = 'Modern No. 20';
            app.JoinGameButton.FontSize = 36;
            app.JoinGameButton.Position = [347 182 170 92];
            app.JoinGameButton.Text = 'Join Game';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = President_exported

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