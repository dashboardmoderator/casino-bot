import discord
import asyncio
from discord.ext import commands
from modules.helpers import *


client = commands.Bot(
    command_prefix=PREFIX,
    owner_ids=OWNER_IDS,
    intents=discord.Intents.all()
)

client.remove_command('help')

async def main():
    for filename in os.listdir(COG_FOLDER):
        if filename.endswith('.py'):
            await client.load_extension(f'cogs.{filename[:-3]}')
    await client.start(TOKEN)

if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("Bot stopped by user.")
    except Exception as e:
        print(f"An error occurred: {e}")   
