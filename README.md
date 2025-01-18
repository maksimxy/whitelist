FiveM Discord Whitelist Script
Setup

    Import the db.sql file into your database to create the whitelist table. This table stores Discord IDs of players who are whitelisted on the server.

Usage

This script is designed for use with FiveM (a multiplayer modification framework for GTA V). It handles player connection events, checking if a player is whitelisted based on their Discord ID. If a player is not whitelisted, they will be denied entry to the server.

    Player Connection Handling
    When a player tries to connect to the server, the playerConnecting event is triggered. The script checks if the player's Discord ID is stored in the whitelist table in the database:
        If the player’s Discord ID is found in the whitelist, they are allowed to connect to the server, and a success message is logged.
        If the player’s Discord ID is not found in the whitelist, they will be denied access with a message stating they are not whitelisted.
        If the player does not have a Discord ID (e.g., it's missing or invalid), they will be prompted to link their Discord.

    Whitelist Command
    The whitelist command allows server admins to manually add a Discord ID to the whitelist via the console. Here's how it works:
        When the command is run (e.g., /whitelist <discordId>), the server checks if the provided Discord ID is already whitelisted.
        If the Discord ID is not yet whitelisted, it will be added to the database and a success message will be logged.
        If the Discord ID is already whitelisted, an "already exists" message will be shown to prevent duplicates.

    Logging
    Whenever a player successfully joins or fails to join, or when an admin performs actions like adding a player to the whitelist, a message is sent to a webhook (such as a Discord channel). This allows for easy tracking and monitoring of whitelist activities.

Webhook Logging

    The log function is used to send logs to a specified webhook URL. These logs include:
        Success or error messages related to player connections and whitelist management.
        Timestamps of actions performed (e.g., adding a new Discord ID to the whitelist).
        All logs are sent with a red color and are timestamped in the format DD.MM.YY - HH:MM:SS.

Example Usage

    When a player connects to the server, the system will check if their Discord ID is in the whitelist. If it is, they will be allowed to join:
        Success Message: "Player [PlayerName] has joined the server successfully."
        Failure Message: "Player [PlayerName] is not whitelisted."

    Admins can use the following command to whitelist a Discord ID via the console:
        Command: /whitelist <discordId>
        Success: The Discord ID is added to the whitelist.
        Error: The ID is already on the whitelist, or there is a failure when adding.

This setup ensures that only authorized players, with verified Discord accounts, can join your FiveM server. It is especially useful for servers that require stricter access control based on Discord membership.
