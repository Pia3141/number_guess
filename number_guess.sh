#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

RANDOM_NUMBER=$((1 + RANDOM % 1000))


ADD_USER(){
  INSERT_USER_RESULT="$($PSQL "INSERT INTO users(name) VALUES ('$USERNAME')")"
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


}

GAME
