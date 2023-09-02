/* See LICENSE file for copyright and license details. */

/* interval between updates (in ms) */
const unsigned int interval = 1000;

/* text to show if no value can be retrieved */
static const char unknown_str[] = "n/a";

/* maximum output string length */
#define MAXLEN 2048

static const struct arg args[] = {
/*  { run_command,	" ^c#1d2021^^b#ea6962^fg() %s ","sh /home/alex/.scripts/statusbar/sb-kbselect"},
    { cpu_perc, "^fg(e5e500)[CPU  %s%%]^^fg()", NULL	      },
    { ram_perc, "^fg(222222)[RAM  %s%%]^^fg()", NULL	      },*/
    { run_command,	"^fg(7daea3)󱀞 %s%%^fg() ","pamixer --get-volume"},
    { run_command,	"^fg(d8a657)󰋊%s^fg() ","sh /home/alex/.scripts/statusbar/sb-disk"},
    { battery_perc, "^fg(a9b665) %s%%^fg() ","BAT1"},
    { wifi_perc,	"^fg(a9b665) %s%%^fg() ",	"wlan0"},
    /*{ datetime,     " ^c#1d2021^^b#d79921^fg() ^b#fabd2f^fg()%s ^d^", "'+%R'"},
    { run_command,     " ^c#1d2021^^b#d55d0e^fg() ^b#fd8019^fg()%s ^d^fg()", "+%a, %d %b"},*/
    { run_command,     "^fg(d8a657)󰥔 %s^fg() ", "date -u '+%r'"},
    { run_command,     "^fg(FCAB6A) %s^fg() ", "date -u '+%a, %d %b'"},
};
