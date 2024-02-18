#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

RANDOM_NUMBER=$((1 + RANDOM % 1000))
TRIES=0

ADD_USER(){
  INSERT_USER_RESULT="$($PSQL "INSERT INTO users(name) VALUES ('$USERNAME')")"
}

ADD_GAME(){
  INSERT_GAME_RESULT="$($PSQL "INSERT INTO games(user_id, guesses) VALUES ($GET_USER_ID, $TRIES)")"
}

GUESS(){

  if [[ -n $1 ]]
  then echo -e "\n$1"
  fi
  
  read GUESS_NUMBER
  if [[ ! $GUESS_NUMBER =~ [0-9]+ ]]
  then
    GUESS "That is not an integer, guess again:"
  fi

  if [[ $GUESS_NUMBER -lt $RANDOM_NUMBER ]]
  then
    TRIES=$((TRIES+1))
    GUESS "It's higher than that, guess again:"
  elif [[ $GUESS_NUMBER -gt $RANDOM_NUMBER ]]
  then
    TRIES=$((TRIES+1))
    GUESS "It's lower than that, guess again:"
  else 
   echo -e "\nYou guessed it in $TRIES tries. The secret number was $RANDOM_NUMBER. Nice job!"
  fi
  
}

GAME(){
echo -e "\n~~~ Number Guessing Game ~~~\n"
echo "Enter your username:"
read  USERNAME;

GET_USER_ID=$($PSQL "SELECT user_id FROM users WHERE name='$USERNAME'")
  
  if [[ -z $GET_USER_ID ]]
  then
    ADD_USER
    echo "Welcome, $USERNAME! It looks like this is your first time here."
  else
    echo "Welcome back, $USERNAME! You have played games, and your best game took guesses."
  fi

  echo -e "\nGuess the secret number between 1 and 1000:"
  GUESS
  ADD_GAME

}

GAME
