classdef RulesPopupExported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure         matlab.ui.Figure
        lmaohiLabel      matlab.ui.control.Label
        ExitRulesButton  matlab.ui.control.Button
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, Test)

        end

        % Button pushed function: ExitRulesButton
        function ExitRulesButtonPushed(app, event)
            delete(app)
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.4667 0.6745 0.1882];
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create ExitRulesButton
            app.ExitRulesButton = uibutton(app.UIFigure, 'push');
            app.ExitRulesButton.ButtonPushedFcn = createCallbackFcn(app, @ExitRulesButtonPushed, true);
            app.ExitRulesButton.Position = [26 435 100 23];
            app.ExitRulesButton.Text = 'Exit Rules';

            % Create lmaohiLabel
            app.lmaohiLabel = uilabel(app.UIFigure);
            app.lmaohiLabel.VerticalAlignment = 'top';
            app.lmaohiLabel.WordWrap = 'on';
            app.lmaohiLabel.FontColor = [1 1 1];
            app.lmaohiLabel.Position = [1 109 640 310];
            app.lmaohiLabel.Text = {'At the start of the game, the entire deck (excluding Jokers, which are not a part of the game) is distributed among the players as evenly as possible.'; 'For division purposes, the game is best played with four-players in which each player receives 13 cards. A three-player variant is possible, in which two players start with 17 cards and one player with 18 cards.'; 'Decks are concealed from other players. '; 'The game is played in rounds that consist of rotating turns. The first turn of the first round is played by the player with ace of spades. The player can play any set of cards they want, whether it be a single, double, triple, or quadruple. The following players have two options:'; ''; '1:Play cards, the value and quantity of which is determined by the preceding turn. Any following player must play a set of cards valued greater than that of the previous player’s card set. For example, if the first player plays two 4’s, then the next player must play at least two cards whose value is at least 5. To clarify, the cards played in a given turn must be of equal value. For example, a player can play two 3’s, but not a 3 and a 4.'; ''; '2:Pass their turn. This is an option if a player does not have a card of a high enough value or card or an insufficient quantity of cards. This can also be a strategic decision to retain high value cards.'; ''; 'The round ends after either an ace (the highest value card) has been placed, or if all other players pass their turn. After a round is ended, a new round is begun starting with the last player to play a card in the previous round. While winning a round does not award the player any points, it provides an opportunity for the player to choose the starting cards for the next round. Rounds will continue until a victorious player has played all of their cards. '};

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = RulesPopupExported(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

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