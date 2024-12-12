from telegram import Update
from telegram.ext import Updater, CommandHandler, CallbackContext
import requests

# Your Bot API Token
TOKEN = "7934648688:AAHfMtNFvNSrQjZxBz9P0S_g1zaGDDKjEdE"

# Admin User IDs (Replace with Telegram User IDs)
ADMIN_IDS = [7934648688, 7934648688]

# Simulated Server Status
server_status = {"status": "Running"}

# Start Command
def start(update: Update, context: CallbackContext) -> None:
    update.message.reply_text("Welcome to the BGMI Server Bot! Use /status to check the server or /freeze (Admin only).")

# Check Server Status
def status(update: Update, context: CallbackContext) -> None:
    update.message.reply_text(f"Server Status: {server_status['status']}")

# Freeze Server (Admin Only)
def freeze(update: Update, context: CallbackContext) -> None:
    if update.effective_user.id in ADMIN_IDS:
        server_status["status"] = "Frozen"
        update.message.reply_text("Server has been frozen.")
    else:
        update.message.reply_text("You are not authorized to use this command.")

# Unfreeze Server (Admin Only)
def unfreeze(update: Update, context: CallbackContext) -> None:
    if update.effective_user.id in ADMIN_IDS:
        server_status["status"] = "Running"
        update.message.reply_text("Server has been unfrozen.")
    else:
        update.message.reply_text("You are not authorized to use this command.")

# Main Function
def main():
    updater = Updater(TOKEN)

    dp = updater.dispatcher

    # Command Handlers
    dp.add_handler(CommandHandler("start", start))
    dp.add_handler(CommandHandler("status", status))
    dp.add_handler(CommandHandler("freeze", freeze))
    dp.add_handler(CommandHandler("unfreeze", unfreeze))

    # Start the Bot
    updater.start_polling()
    updater.idle()

if __name__ == "__main__":
    main()
    
