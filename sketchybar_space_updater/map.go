package main

func IconMap(app string) string {
	switch app {
	case "Keynote":
		fallthrough
	case "Keynote 讲演":
		return ":keynote:"
	case "Figma":
		return ":figma:"
	case "VMware Fusion":
		return ":vmware_fusion:"
	case "Alacritty":
		fallthrough
	case "Hyper":
		fallthrough
	case "iTerm2":
		fallthrough
	case "kitty":
		fallthrough
	case "Terminal":
		fallthrough
	case "终端":
		fallthrough
	case "WezTerm":
		fallthrough
	case "Ghostty":
		return ":terminal:"
	case "Microsoft To Do":
		fallthrough
	case "Things":
		return ":things:"
	case "Keyboard Maestro":
		return ":keyboard_maestro:"
	case "App Store":
		return ":app_store:"
	case "CleanMyMac X":
		return ":desktop:"
	case "Android Messages":
		return ":android_messages:"
	case "Reeder":
		return ":reeder5:"
	case "Joplin":
		return ":joplin:"
	case "Discord":
		fallthrough
	case "Discord Canary":
		fallthrough
	case "Discord PTB":
		return ":discord:"
	case "Logseq":
		return ":logseq:"
	case "Microsoft Excel":
		return ":microsoft_excel:"
	case "Microsoft PowerPoint":
		return ":microsoft_power_point:"
	case "Telegram":
		return ":telegram:"
	case "Transmit":
		return ":transmit:"
	case "Pi-hole Remote":
		return ":pihole:"
	case "League of Legends":
		return ":league_of_legends:"
	case "Element":
		return ":element:"
	case "Zulip":
		return ":zulip:"
	case "Sequel Ace":
		return ":sequel_ace:"
	case "Zed Preview":
		fallthrough
	case "Zed":
		return ":zed:"
	case "Zen Browser":
		return ":zen_browser:"
	case "TeamSpeak 3":
		return ":team_speak:"
	case "1Password":
		return ":one_password:"
	case "Caprine":
		return ":caprine:"
	case "카카오톡":
		return ":kakaotalk:"
	case "Dropbox":
		return ":dropbox:"
	case "Kakoune":
		return ":kakoune:"
	case "Rider":
		fallthrough
	case "JetBrains Rider":
		return ":rider:"
	case "Godot":
		return ":godot:"
	case "qutebrowser":
		return ":qute_browser:"
	case "Typora":
		return ":text:"
	case "Sequel Pro":
		return ":sequel_pro:"
	case "Reminders":
		fallthrough
	case "提醒事项":
		return ":reminders:"
	case "Setapp":
		return ":setapp:"
	case "Finder":
		fallthrough
	case "访达":
		return ":finder:"
	case "Matlab":
		return ":matlab:"
	case "LibreWolf":
		return ":libre_wolf:"
	case "Notes":
		fallthrough
	case "备忘录":
		return ":notes:"
	case "Notion":
		return ":notion:"
	case "Brave Browser":
		return ":brave_browser:"
	case "Spotlight":
		return ":spotlight:"
	case "Iris":
		return ":iris:"
	case "Tower":
		return ":tower:"
	case "Jellyfin Media Player":
		return ":jellyfin:"
	case "Code":
		fallthrough
	case "Code - Insiders":
		return ":code:"
	case "Linear":
		return ":linear:"
	case "Live":
		return ":ableton:"
	case "Parallels Desktop":
		return ":parallels:"
	case "Final Cut Pro":
		return ":final_cut_pro:"
	case "Chromium":
		fallthrough
	case "Google Chrome":
		fallthrough
	case "Google Chrome Canary":
		return ":google_chrome:"
	case "GitHub Desktop":
		return ":git_hub:"
	case "Firefox":
		return ":firefox:"
	case "Slack":
		return ":slack:"
	case "Spotify":
		return ":spotify:"
	case "Neovide":
		fallthrough
	case "MacVim":
		fallthrough
	case "Vim":
		fallthrough
	case "VimR":
		return ":vim:"
	case "KeePassXC":
		return ":kee_pass_x_c:"
	case "PomoDone App":
		return ":pomodone:"
	case "DEVONthink 3":
		return ":devonthink3:"
	case "Color Picker":
		fallthrough
	case "数码测色计":
		return ":color_picker:"
	case "Tweetbot":
		fallthrough
	case "Twitter":
		return ":twitter:"
	case "Default":
		return ":default:"
	case "Pages":
		fallthrough
	case "Pages 文稿":
		return ":pages:"
	case "Emacs":
		return ":emacs:"
	case "MAMP":
		fallthrough
	case "MAMP PRO":
		return ":mamp:"
	case "Canary Mail":
		fallthrough
	case "HEY":
		fallthrough
	case "Mail":
		fallthrough
	case "Mailspring":
		fallthrough
	case "MailMate":
		fallthrough
	case "邮件":
		return ":mail:"
	case "WebStorm":
		return ":web_storm:"
	case "TickTick":
		return ":tick_tick:"
	case "TIDAL":
		return ":tidal:"
	case "VLC":
		return ":vlc:"
	case "Blender":
		return ":blender:"
	case "Music":
		fallthrough
	case "音乐":
		return ":music:"
	case "Calendar":
		fallthrough
	case "日历":
		fallthrough
	case "Fantastical":
		fallthrough
	case "Cron":
		fallthrough
	case "Amie":
		return ":calendar:"
	case "Evernote Legacy":
		return ":evernote_legacy:"
	case "Microsoft Word":
		return ":microsoft_word:"
	case "Safari":
		fallthrough
	case "Safari浏览器":
		fallthrough
	case "Safari Technology Preview":
		return ":safari:"
	case "MoneyMoney":
		return ":bank:"
	case "Xcode":
		return ":xcode:"
	case "Numbers":
		fallthrough
	case "Numbers 表格":
		return ":numbers:"
	case "ClickUp":
		return ":click_up:"
	case "Arc":
		return ":arc:"
	case "Zeplin":
		return ":zeplin:"
	case "Trello":
		return ":trello:"
	case "Vivaldi":
		return ":vivaldi:"
	case "Calibre":
		return ":book:"
	case "Min":
		return ":min_browser:"
	case "网易云音乐":
		return ":netease_music:"
	case "GrandTotal":
		fallthrough
	case "Receipts":
		return ":dollar:"
	case "zoom.us":
		return ":zoom:"
	case "Folx":
		return ":folx:"
	case "微信":
		return ":wechat:"
	case "Orion":
		fallthrough
	case "Orion RC":
		return ":orion:"
	case "Notability":
		return ":notability:"
	case "Todoist":
		return ":todoist:"
	case "Replit":
		return ":replit:"
	case "Tor Browser":
		return ":tor_browser:"
	case "Drafts":
		return ":drafts:"
	case "Preview":
		fallthrough
	case "预览":
		fallthrough
	case "Skim":
		fallthrough
	case "zathura":
		return ":pdf:"
	case "PyCharm":
		return ":pycharm:"
	case "Audacity":
		return ":audacity:"
	case "Cypress":
		return ":cypress:"
	case "VSCodium":
		return ":vscodium:"
	case "Podcasts":
		fallthrough
	case "播客":
		return ":podcasts:"
	case "DingTalk":
		fallthrough
	case "钉钉":
		fallthrough
	case "阿里钉":
		return ":dingtalk:"
	case "OBS":
		return ":obsstudio:"
	case "Firefox Developer Edition":
		fallthrough
	case "Firefox Nightly":
		return ":firefox_developer_edition:"
	case "Alfred":
		return ":alfred:"
	case "OmniFocus":
		return ":omni_focus:"
	case "Skype":
		return ":skype:"
	case "Spark Desktop":
		return ":spark:"
	case "Docker":
		fallthrough
	case "Docker Desktop":
		return ":docker:"
	case "Signal":
		return ":signal:"
	case "Pine":
		return ":pine:"
	case "Insomnia":
		return ":insomnia:"
	case "Microsoft Edge":
		return ":microsoft_edge:"
	case "Affinity Photo":
		return ":affinity_photo:"
	case "Sketch":
		return ":sketch:"
	case "Android Studio":
		return ":android_studio:"
	case "Bitwarden":
		return ":bit_warden:"
	case "Affinity Publisher":
		return ":affinity_publisher:"
	case "Zotero":
		return ":zotero:"
	case "Sublime Text":
		return ":sublime_text:"
	case "Warp":
		return ":warp:"
	case "Messages":
		fallthrough
	case "信息":
		fallthrough
	case "Nachrichten":
		return ":messages:"
	case "Obsidian":
		return ":obsidian:"
	case "IntelliJ IDEA":
		return ":idea:"
	case "Atom":
		return ":atom:"
	case "FaceTime":
		fallthrough
	case "FaceTime 通话":
		return ":face_time:"
	case "Yuque":
		fallthrough
	case "语雀":
		return ":yuque:"
	case "Grammarly Editor":
		return ":grammarly:"
	case "Mattermost":
		return ":mattermost:"
	case "Affinity Designer":
		return ":affinity_designer:"
	case "mpv":
		return ":mpv:"
	case "Thunderbird":
		return ":thunderbird:"
	case "Airmail":
		return ":airmail:"
	case "Microsoft Teams":
		return ":microsoft_teams:"
	case "Bear":
		return ":bear:"
	case "System Preferences":
		fallthrough
	case "System Settings":
		fallthrough
	case "系统设置":
		return ":gear:"
	case "Nova":
		return ":nova:"
	case "WhatsApp":
		return ":whats_app:"
	default:
		return ":default:"
	}
}
