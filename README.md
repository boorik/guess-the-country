# guess-the-country

# Resources

https://restcountries.com/

# TODO for the next sessions :
- Score calculation (abstraction, strategy pattern)
- param the number of answers for a question
- improve UI
- Wrap game with several mods (Timed, less hint possible, ...)
- Quit game button (with confirmation message)
- Hint scroll to rework
- Hint text size (big text not well handled)
- Hint number units formatting
- Add missing tests
- Rename test functions
- Bug last question response
- Refactor back button with builder (attention de bien passer la callback)

- Continue test with swift-testing

- Conception: 
  - Think how to make an abstraction of the game model
  - Think how to make rules for multiplayer game
  
  
# client-server

- client: bouton multi-solo (in progress)
- client: new game; join game
- server: Auth???

GameKit (in progress) + server vapor?


# Multiplayer rules 

- Same question for every player
- Max Player : 4 and can scale later
- Flag only for now as hint
- First having the good answer wins the question
- zero point for wrong response
- Order score by order of players having the correct answer


# Host choice

- First player launch : chooseBestHostingPlayer()
- if no response (or empty ?) : first player is the host
- player sends to other player who is the host.
