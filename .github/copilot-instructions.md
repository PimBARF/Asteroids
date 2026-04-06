# Project Guidelines

## Code Style
- This project is a small Love2D game written in Lua.
- Modules are defined as local tables and returned at the end of each file.
- Use `:` method syntax for module methods that operate on `self` (for example, `function player:update(dt)`).
- Keep state contained in modules rather than using globals.
- File names match module names: `player.lua`, `bullets.lua`, `asteroids.lua`, `collisions.lua`, `ui.lua`, `utils.lua`.

## Architecture
- `main.lua` orchestrates Love2D callbacks: `love.load`, `love.update`, and `love.draw`.
- The game state is managed in `main.lua` with modes: `menu`, `playing`, and `gameover`.
- `player.lua`, `bullets.lua`, and `asteroids.lua` each manage their own spawn/update/draw behavior.
- `collisions.lua` contains collision detection and game-response logic.
- `ui.lua` handles menu, HUD, and game-over rendering.
- `utils.lua` provides shared helper functions like screen wrapping and circle-based collision checks.

## Build and Test
- There is no dedicated test suite yet.
- Run the game from the project root using Love2D:
  - `love .`
- Editor settings already target LuaJIT and Love2D runtime support via `.vscode/settings.json`.

## Conventions
- Keep modules small and single-purpose.
- Add new collision shapes and object intersection logic in `utils.lua`, not spread across modules.
- When resetting the game, preserve the pattern in `main.lua` and reset module state through their exposed APIs.
- Avoid introducing new global variables; use local module state instead.
- Prefer descriptive naming and keep game logic in Lua modules rather than in the UI or main callback scaffolding.
