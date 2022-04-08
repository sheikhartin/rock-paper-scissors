#!/bin/bash

read -p "How many rounds do you want to play? " rounds
if [[ "${rounds}" -le 0 ]]; then
  echo "The number of rounds must be greater than 0."
  exit 1
fi

for (( i = 1; i <= rounds; i++ )); do
  echo -e "\n============ ROUND ${i} ============"
  computer_move="$(echo "rock paper scissors" | cut -d' ' -f"$(shuf -i1-3 -n1)")"

  # The game may not be fair, especially for who reads the code!
  if [[ "${1}" == "planetsheikh" ]]; then
    echo "Shush! The computer wants to play with ${computer_move}."
  fi

  read -p "[R]ock, [P]aper or [S]cissors? " user_move
  user_move="$(sed -E 's/^[r(ock)?|1]$/rock/;s/^[p(aper)?|2]$/paper/;s/^[s(cissors)?|3]$/scissors/' <<< "${user_move,,}")"
  if [[ ! "${user_move}" =~ ^(rock|paper|scissors)$ ]]; then
    echo "That is not a legal move!"
    continue
  fi

  if [[ "${user_move}" == "${computer_move}" ]]; then
    echo "It's a tie!"
  elif ([[ "${user_move}" == "rock" && "${computer_move}" == "scissors" ]]) \
    || ([[ "${user_move}" == "paper" && "${computer_move}" == "rock" ]]) \
    || ([[ "${user_move}" == "scissors" && "${computer_move}" == "paper" ]]); then
    echo "Hooray! The computer lose with ${computer_move}."
  else
    echo "You fucked up! The computer played ${computer_move}."
  fi
done
