# Tic-Tac-Toe in Ruby

To play the game, just clone this repository, `bundle install` and run `bundle exec ruby bin/play`. You should see something like this:

    Do you want to play with X or O? X
    Welcome to a game of Tic-Tac-Toe!
    The board positions can be selected by using the Numpad.
     7 | 8 | 9
    -----------
     4 | 5 | 6
    -----------
     1 | 2 | 3
    Please enter move for player X:

### Updating the game

`git pull` will fetch the current version of the game. Always make sure to `bundle install` and `rm -rf tmp/*` before attempting to run the game. 
    
### Tests and contributing

The game contains some unit tests. In order to run the tests do the following:

- Make sure you have Ruby 2.1.5 and the [Bundler gem](http://bundler.io)
- `bundle install`
- `bundle exec rspec`
