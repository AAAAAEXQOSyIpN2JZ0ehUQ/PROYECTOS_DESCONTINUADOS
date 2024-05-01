/*
* HCDrill v1.0.2 - Telegram version
* Coded by PANCHO7532 - P7COMunications LLC
* Copyright (c) HCTools Group - 2020
*
* This program comes with a LICENSE file that you must read before redistributing or modifying this code.
*/
const fs = require('fs');
const path = require('path');
const util = require("util");
const syncRequest = require('sync-request');
var botToken = "1178493298:AAHX0cfphL6T2mRFadLn48AVjkeQgewnFgE";
var cleanFiles = true;
var downloadDirectory = "storage/"; //for store incoming files
var showHelp = false;
const validExtensions = [
    ".acm",
    ".zxc",
    ".hc"
];
//splash
console.log("HCDrill v1.0.2\r\nCopyright (c) HCTools Group - 2020\r\nCoded by P7COMunications LLC");
for(c = 0; c < process.argv.length; c++) {
    switch(process.argv[c]) {
        case "--botToken":
        case "-bt":
            botToken = process.argv[c+1];
            break;
        case "--dir":
        case "-d":
            downloadDirectory = process.argv[c+1];
            break;
        case "--conserve":
        case "-c":
            cleanFiles = false;
            break;
        case "--help":
        case "-h":
            showHelp = true;
            break;
    }
}
if(showHelp) {
    var helpContent = [
        "Usage: node script.js [--args -a...]",
        "",
        "--botToken, -bt\t\tSet your bot token",
        "--dir, -d\t\tSet a custom download dir for incoming files",
        "--conserve, -c\t\tConserve uploaded files",
        "--help, -h\t\tDisplay this help text"
    ];
    for(c=0; c < helpContent.length; c++) {
        console.log(helpContent[c]);
    }
    process.exit();
}
const apiTelegram = require('node-telegram-bot-api');
const bot = new apiTelegram(botToken, {polling: true});
function fileDownload(url) {
    //this will return the filename of the file saved
    var request = syncRequest("GET", url);
    if(request["statusCode"] != 200) {
        return -1;
    }
    if(!request["headers"]["content-length"]) {
        return -1;
    }
    if(request["headers"]["content-length"] > 10000000) {
        //limit cap to 10MB in server response
        return -2;
    }
    fs.writeFileSync(downloadDirectory + path.parse(url)["base"], request["body"]);
    return path.parse(url)["base"];
}
bot.on("message", function(message) {
    if(message.from.is_bot) { return; } //ignoring messages from bots
    if(!message.document) { return; } //ignoring any other messages that aren't a document or raw file
    //[15/09] - start writing this section once i finish implementing all js files in lib folder
    /*ignore other file extensions foreign to whitelist*/
    var extPass = false;
    for(c = 0; c < validExtensions.length; c++) {
        if(path.parse(message.document.file_name)["ext"] == validExtensions[c]) {
            extPass = true;
        }
    }
    if(!extPass) { return; };
    bot.getFile(message.document["file_id"]).then(function(result){
        var localFilePath = fileDownload("https://api.telegram.org/file/bot" + botToken + "/" + result["file_path"]);
        if(localFilePath == -1) {
            bot.sendMessage(message.chat.id, "Invalid file or metadata info.", {reply_to_message_id: message.message_id});
            return;
        } else if(localFilePath == -2) {
            bot.sendMessage(message.chat.id, "The file is too heavy!", {reply_to_message_id: message.message_id});
            return
        }
        var localApiResult = JSON.parse(require("./lib/httpCustom").decrypt(fs.readFileSync(downloadDirectory + localFilePath)));
        if(localApiResult["error"] == 1) {
            bot.sendMessage(message.chat.id, "Decryption failed, incompatible encryption method or algorithm.", {reply_to_message_id: message.message_id});
            if(cleanFiles) {
                fs.unlinkSync(downloadDirectory + localFilePath);
            }
            return;
        }
        var decryptedContent = JSON.parse(localApiResult["content"]);
        var response = "";
        response+="(Payload)-> " + decryptedContent["payload"];
        response+="\r\n(Proxy URL)-> " + decryptedContent["proxyURL"];
        response+="\r\n(Config blocked for root devices?)-> " + decryptedContent["blockedRoot"];
        response+="\r\n(Lock Payload and Servers?)-> " + decryptedContent["lockPayloadAndServers"];
        response+="\r\n(Expiration Date)-> " + decryptedContent["expireDate"];
        response+="\r\n(File has notes?)-> " + decryptedContent["containsNotes"];
        response+="\r\n(Note field 1)-> " + decryptedContent["note1"];
        response+="\r\n(SSH Address)-> " + decryptedContent["sshAddr"];
        response+="\r\n(Config blocked for mobile data only?)-> " + decryptedContent["mobileData"];
        response+="\r\n(Unlock Proxy field?)-> " + decryptedContent["unlockProxy"];
        response+="\r\n(OpenVPN configuration file)-> " + decryptedContent["openVPNConfig"];
        response+="\r\n(VPN address)-> " + decryptedContent["VPNAddr"];
        response+="\r\n(SSL/SNI value)-> " + decryptedContent["sslsni"];
        response+="\r\n(Connect using SSH?)-> " + decryptedContent["connectSSH"];
        response+="\r\n(UDPGW Port)-> " + decryptedContent["udpgwPort"];
        response+="\r\n(Lock Payload only?)-> " + decryptedContent["lockPayload"];
        response+="\r\n(File locked with HWID?)-> " + decryptedContent["hwidEnabled"];
        response+="\r\n(HWID value)-> " + decryptedContent["hwidValue"];
        response+="\r\n(Note field 2)-> " + decryptedContent["note2"];
        response+="\r\n(Unlock User and Password fields?)-> " + decryptedContent["unlockUserAndPassword"];
        response+="\r\n(SSL + Payload mode?)-> " + decryptedContent["sslPayloadMode"];
        response+="\r\n(Password protected file?)-> " + decryptedContent["passwordProtected"];
        response+="\r\n(Password value)-> " + decryptedContent["passwordValue"]
        if(!!message.caption && message.caption.indexOf("raw") != -1) {
            response+="\r\n(RAW Value)-> " + decryptedContent["raw"];
        }
        if(!!message.caption && message.caption.indexOf("json") != -1) {
            response = JSON.stringify(decryptedContent);
        }
        response += "\r\n\r\nSatisfied with the result? Follow us!\r\n\u{1F310} BOT CHANNEL: @hctoolschannel\r\n\u{1F310} BOT GROUP: @hctools\r\n\u{1F4BB} SOURCE CODE: https://github.com/hctools/hcdrill-tg";
        if(response.length > 4096) {
            if(response.length < 8192) {
                //it's under THAT two message limit
                bot.sendMessage(message.chat.id, response.substring(0, 4096), {reply_to_message_id: message.message_id}).then(function(){
                    var response2 = response.substring(Math.round(4096, response.length));
                    bot.sendMessage(message.chat.id, response2, {reply_to_message_id: message.message_id});
                });
            } else {
                //we cant afford a two message split with this length, so, for avoid spam, we send it as a document instead.
                bot.sendDocument(message.chat.id, Buffer.from(response), {caption: "The decrypted content is too large to be sent on Telegram. Instead we sent you a text file with the decrypted data.\r\n\r\nSatisfied with the result? Follow us!\r\n\u{1F310} BOT CHANNEL: @hctoolschannel\r\n\u{1F310} BOT GROUP: @hctools\r\n\u{1F4BB} SOURCE CODE: https://github.com/hctools/hcdrill-tg", reply_to_message_id: message.message_id}, {filename: message.from.id + "_" + response.length + Math.round(Math.random()*1000) + ".txt", contentType: "application/octet-stream"});
            }
        } else {
            bot.sendMessage(message.chat.id, response, {reply_to_message_id: message.message_id});
        }
        //deleting file so we dont acumulate a lot of files on the download directory
        if(cleanFiles) {
            fs.unlinkSync(downloadDirectory + localFilePath);
        }
    });
});
bot.on('polling_error', function(error) {
    console.log("[ERROR] - Polling error:\r\n" + error);
});
console.log("[INFO] - Bot started!");
