# NES Controller Pong on FPGA

This project implements a 2-player Pong game on an FPGA using NES controllers. Players control paddles, score points, and restart the game using the NES controllers. The game runs entirely on the FPGA, including game logic, input processing, and display.

## Domument

[Pong](https://narrow-theory-18d.notion.site/NES-controller-Pong-on-FPGA-1b9436c3d41a8186a3e4e2e46e7fc9a8?pvs=74)

## Overview

- **Game Type**: Two-player Pong
- **Player Input**: NES controllers
  - **Paddles**: Controlled via NES controller buttons (up/down)
  - **Game Start**: Press a button to start the game
- **Ball Movement**: The ball moves at 45-degree angles and speeds up when it hits a paddle.
- **Game Over**: The game ends when one player reaches 5 points.
  
## Key Components

| **Component**    | **Purpose** |
|------------------|-------------|
| **Ball**         | Tracks position, velocity, and ball-wall/paddle collisions |
| **Score**        | Keeps track of player scores |
| **Seven Seg**    | Displays the score on a 7-segment display |
| **Paddle**       | Controls paddle movement based on NES controller input |
| **NES**          | Decodes input from NES controllers for paddle control |
| **Game State**   | Manages game state (Playing / Game Over) |
| **Pattern Gen**  | Controls pixel color generation based on game state |
| **VGA**          | Outputs game visuals to a VGA display |
| **PLL & HSOSC**  | Generates clock signals for system and VGA display |

## Game Logic

- **Ball Position & Velocity**: 
  - The ball’s position is tracked with 10-bit vectors.
  - Velocity is stored as a 2-bit vector representing the ball's direction and speed.
- **Collision Detection**: 
  - When the ball collides with the top or bottom walls, it bounces vertically.
  - If the ball hits a paddle, it changes direction and speed.
- **Scoring**: 
  - When the ball passes a player’s paddle, the opponent scores a point.
  - The ball is reset to the center after a point is scored.
- **Game Over**: 
  - The game ends when one player scores 5 points.
  - The screen displays "Game Over" when a player wins.

## Setup Instructions

1. **Hardware Requirements**:
   - FPGA development board (e.g., Basys 3, Nexys 4)
   - Two NES controllers connected to the FPGA

2. **Software**:
   - FPGA programming tools (e.g., Vivado)
   - NES controller library (for decoding controller inputs)

3. **Connection**:
   - Connect the FPGA to a VGA monitor to display the game.
   - Connect the NES controllers to the FPGA for player input.
