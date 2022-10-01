/* See LICENSE file for copyright and license details. */

/* interval between updates (in ms) */
const unsigned int interval = 1000;

/* text to show if no value can be retrieved */
static const char unknown_str[] = "null";

/* maximum output string length */
#define MAXLEN 2048

static const struct arg args[] = {
    { run_command,	" ^c#1d2021^^b#ea6962^  %s ","sh /home/alex/.scripts/statusbar/sb-kbselect"},
    { run_command,	" ^c#1d2021^^b#7daea3^   %s%% ","pamixer --get-volume"},
    { run_command,	" ^c#1d2021^^b#d8a657^  %s ","sh /home/alex/.scripts/statusbar/sb-disk"},
	{ battery_perc, " ^c#1d2021^^b#a9b665^   %s%% ","BAT1"},
	{ wifi_perc,	" ^c#1d2021^^b#a9b665^   %s%% ",	"wlan0"},
    /*{ datetime,     " ^c#1d2021^^b#d79921^  ^b#fabd2f^ %s ^d^", "'+%R'"},
    { run_command,     " ^c#1d2021^^b#d55d0e^  ^b#fd8019^ %s ^d^ ", "+%a, %d %b"},*/
    { run_command,     " ^c#1d2021^^b#d8a657^   %s ", "date -u '+%R'"},
    { run_command,     " ^c#1d2021^^b#FCAB6A^   %s  ", "date -u '+%a, %d %b'"},
};
