import random
import nigui
import strformat


# Define game object
type
    game = object
        wins: int
        loses: int
        ties: int

# Start current game
var currentGame = game(wins: 0, loses: 0, ties: 0)

# Procedure to get a random choice from the computer
proc getComputerChoice(): string =

    # Define options available to the computer
    const computerOptions = ["rock", "paper", "scissors"]

    # Choose one randomly and return it
    randomize()
    return sample(computerOptions)

# Procedure to update game
proc updateGame(playerChoice: string, window: Window, computerChoice = getComputerChoice()) : string =

    # Define game messages 
    var
        won = &"Computer choice: {computerChoice}\n\nYOU WON!!!"
        lose = &"Computer choice: {computerChoice}\n\nYou lost..."
        tie = &"Computer choice: {computerChoice}\n\nTIE"

    # Check to see whether player won, lost, tied and update game
    if playerChoice == computerChoice:
        window.alert(tie)
        inc currentGame.ties
    case playerChoice:
        of "rock":
            if computerChoice == "scissors":
                window.alert(won)
                inc currentGame.wins
            elif computerChoice == "paper": 
                window.alert(lose)
                inc currentGame.loses
        of "paper":
            if computerChoice == "rock":
                window.alert(won)
                inc currentGame.wins
            elif computerChoice == "scissors":
                window.alert(lose)
                inc currentGame.loses
        of "scissors":
            if computerChoice == "paper":
                window.alert(won)
                inc currentGame.wins
            elif computerChoice == "rock":
                window.alert(lose)
                inc currentGame.loses

    # Return current game
    return(&"Tries: {currentGame.wins + currentGame.loses + currentGame.ties}\nWins: {currentGame.wins} Loses: {currentGame.loses} Ties: {currentGame.ties}")

# Main procedure
proc main() =

    # Initialize application
    app.init()

    # Create a window
    var window = newWindow("Rock, Paper, Scissors")

    # Set size of the window
    window.width = 620.scaleToDpi
    window.height = 400.scaleToDpi

    # Create a container and add it to the window
    var container = newContainer()
    window.add(container)

    # Create 3 buttons
    var
        rock_button = newButton("Rock")
        paper_button = newButton("Paper")
        scissors_button = newButton("Scissors")

    # Add buttons to container
    container.add(rock_button)
    container.add(paper_button)
    container.add(scissors_button)
    rock_button.x = 0
    rock_button.y = 0
    paper_button.x = 200
    paper_button.y = 0
    scissors_button.x = 400
    scissors_button.y = 0

    # Define and change width and height for buttons
    const buttonWidth = 200
    const buttonHeight = 50
    rock_button.width = buttonWidth
    rock_button.height = buttonHeight
    paper_button.width = buttonWidth
    paper_button.height = buttonHeight
    scissors_button.width = buttonWidth
    scissors_button.height = buttonHeight

    # Add label to container
    var label = newLabel()
    container.add(label)
    label.x = 200
    label.y = 200

    # Change width and height of label
    label.width = 400
    label.height = 50

    # Update game depending on player's choice and computer's choice
    rock_button.onClick = proc(event: ClickEvent) =
        label.text = updateGame("rock", window)
    paper_button.onClick = proc(event: ClickEvent) =
        label.text = updateGame("paper", window)
    scissors_button.onClick = proc(event: ClickEvent) =
        label.text = updateGame("scissors", window)

    # Make the window visible to the screen
    window.show()

    # Run the main loop
    app.run()

# Start app
main()