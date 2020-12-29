# STFU

STFU is an AddOn for World of Warcraft (retail) which blocks the talking head frame. It can be configured to block or allow the frame by zone or subzone.

# Usage

By default, STFU will block talking heads in all Shadowlands dungeons and allow them everywhere else.
This can be changed by using in game slash commands to manipulate the blocklist.

Run `/stfu` in game to see all the possible commands. They are as follows:

`/stfu on` or `/stfu enable`: Enables STFU, allowing it to block talking heads.
`/stfu off` or `/stfu disable`: disables STFU, preventing it from blocking talking heads.
`/stfu toggle zone`: Toggles the inclusion of the current zone (e.g. Orgrimmar) in STFU's blocklist.
`/stfu toggle subzone`: Toggles the inclusion of the current subzone (e.g. Valley of Strength) in STFU's blocklist.
`/stfu list`: Prints a list of all the zones and subzones on the blocklist to the chat.
`/stfu reset`: Sets the blocklist back to its default value, which is all Shadowlands dungeons.
`/stfu clear`: Completely clears the blocklist, removing all zones and subzones.
`/stfu verbose`: Toggles verbose logging. When on, messages will be printed to the main chat frame when talking heads are blocked.

# Acknowledgements

This AddOn is based on the AddOn [BeQuiet](https://github.com/Xorag/BeQuiet) by Xorag.
The primary difference is that STFU allows talking heads by default and blocks them based on a blocklist.

# License

[MIT](https://choosealicense.com/licenses/mit/)
