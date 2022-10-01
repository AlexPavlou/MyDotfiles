#define PATH(name)                      "/home/alex/.scripts/statusbar/"name

static char *delim = " ";

//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	/* {"⌨", "sb-kbselect", 0, 30},
	{"", "cat /tmp/recordingicon 2>/dev/null",	0,	9},
	{"",	"sb-tasks",	10,	26},*/
	//{"",	"sb-music",	1,	1},
    {"",	PATH("sb-volume"),	1,	1},
	{"",	PATH("sb-usb"),	1,	1},
	/*{"",	PATH("sb-pacpackages"),	6,	16},
	{" ",	PATH("sb-news"),		1,	16},*/
	/*{"",	"sb-price lbc \"LBRY Token\" 📚",			9000,	22},
	{"",	"sb-price bat \"Basic Attention Token\" 🦁",	9000,	20},
	{"",	"sb-price link \"Chainlink\" 🔗",			300,	25},
	{"",	"sb-price xmr \"Monero\" 🔒",			9000,	24},
	{"",	"sb-price eth Ethereum 🍸",	9000,	23},
	{"",	"sb-price btc Bitcoin 💰",			9000,	21},*/
	{" ",	PATH("sb-cpu"), 	10,	18},
	{"",   PATH("sb-disk"),	1,	16},
	{"",	PATH("sb-memory"),	1,	16},
	/*{"",	PATH("sb-forecast"),	1800,	5},
	{" ",	PATH("sb-mail"),	1,	16},*/
	{"",	PATH("sb-battery"),	5,	3},
	{"",	PATH("sb-internet"),	5,	4},
	{"",	PATH("sb-clock"),	1,	1},
	{"",	PATH("sb-date"),	1800,	5},
};

// Have dwmblocks automatically recompile and run when you edit this file in
// vim with the following line in your vimrc/init.vim:

// autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }

