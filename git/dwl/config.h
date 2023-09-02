#define TERM "foot"
#define TERMCLASS "Foot"
#define BROWSER "firefox-bin"

#include <X11/XF86keysym.h>

/* appearance */
static const int sloppyfocus               = 1;  /* focus follows mouse */
static const int bypass_surface_visibility = 0;  /* 1 means idle inhibitors will disable idle tracking even if it's surface isn't visible  */
static const int smartgaps                 = 0;  /* 1 means no outer gap when there is only one window */
static const int monoclegaps               = 0;
static const float bordercolor[]           = {0.5, 0.5, 0.5, 1.0};
static const unsigned int borderpx         = 1;  /* border pixel of windows */
static const unsigned int gappih           = 20; /* horiz inner gap between windows */
static const unsigned int gappiv           = 10; /* vert inner gap between windows */
static const unsigned int gappoh           = 10; /* horiz outer gap between windows and screen edge */
static const unsigned int gappov           = 30; /* vert outer gap between windows and screen edge */

static const float focuscolor[]            = {1.0, 0.0, 0.0, 1.0};
static const char cursortheme[]            = "Reimu"; /* theme from /usr/share/cursors/xorg-x11 */
static const unsigned int cursorsize       = 24;
/* To conform the xdg-protocol, set the alpha to zero to restore the old behavior */
static const float fullscreen_bg[]         = {0.1, 0.1, 0.1, 1.0};

/* Autostart */
static const char *const autostart[] = {
        "wbg", "/home/alex/.config/bg/wed.jpg", NULL,
        "sh", "/home/alex/.scripts/wifi.sh", NULL,
        "sh", "/home/alex/.scripts/sound.sh", NULL,
        "sh", "/home/alex/.scripts/bat_stuff.sh", NULL,
        "", "swayidle -w timeout 60 'swaylock -f -c 000000'", NULL,
        "", "light -S 80", NULL,
        NULL /* terminate */
};

/* tagging - tagcount must be no greater than 31 */
static const int tagcount = 4;

/* keyboard layout change notification */
static const char keymapnotifyfile[] = "/tmp/dwl-keymap";
static const char *keymapnotifycmd[] = {"pkill", "-RTMIN+1", "someblocks", NULL};

 static const Rule rules[] = {
        { "Gimp",     NULL,       1 << 8,       0,           0,         0,        -1 },
	{ TERMCLASS,  NULL,       0,            0,           1,         0,        -1 },
	{ BROWSER,    NULL,       1 << 8,       0,           -1,        0,        -1 },
 };

/* layout(s) */
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* monitors
+ * The order in which monitors are defined determines their position.
+ * Non-configured monitors are always added to the left. */
static const MonitorRule monrules[] = {
        /* name       mfact nmaster scale layout       rotate/reflect             x  y resx resy rate adaptive custom*/
        { NULL,       0.5, 1,      1,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, 0, 0, 0, 0, 60.007000, 1, 0},
};

/* keyboard */
static const struct xkb_rule_names xkb_rules = {
	/* can specify fields: rules, model, layout, variant, options */
        .layout = "us,gr",
        .options = "grp:rctrl_switch,grp:toggle",
};

static const int repeat_rate = 50;
static const int repeat_delay = 300;

/* Trackpad */
static const int tap_to_click = 1;
static const int tap_and_drag = 1;
static const int drag_lock = 1;
static const int natural_scrolling = 1;
static const int disable_while_typing = 1;
static const int left_handed = 0;
static const int middle_button_emulation = 0;
/* You can choose between:
LIBINPUT_CONFIG_SCROLL_NO_SCROLL
LIBINPUT_CONFIG_SCROLL_2FG
LIBINPUT_CONFIG_SCROLL_EDGE
LIBINPUT_CONFIG_SCROLL_ON_BUTTON_DOWN
*/
static const enum libinput_config_scroll_method scroll_method = LIBINPUT_CONFIG_SCROLL_2FG;

/* You can choose between:
LIBINPUT_CONFIG_CLICK_METHOD_NONE
LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS
LIBINPUT_CONFIG_CLICK_METHOD_CLICKFINGER
*/
static const enum libinput_config_click_method click_method = LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS;

/* You can choose between:
LIBINPUT_CONFIG_SEND_EVENTS_ENABLED
LIBINPUT_CONFIG_SEND_EVENTS_DISABLED
LIBINPUT_CONFIG_SEND_EVENTS_DISABLED_ON_EXTERNAL_MOUSE
*/
static const uint32_t send_events_mode = LIBINPUT_CONFIG_SEND_EVENTS_ENABLED;

/* You can choose between:
LIBINPUT_CONFIG_ACCEL_PROFILE_FLAT
LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE
*/
static const enum libinput_config_accel_profile accel_profile = LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE;
static const double accel_speed = 0.0;
static const int cursor_timeout = 5;

/* You can choose between:
LIBINPUT_CONFIG_TAP_MAP_LRM -- 1/2/3 finger tap maps to left/right/middle
LIBINPUT_CONFIG_TAP_MAP_LMR -- 1/2/3 finger tap maps to left/middle/right
*/
static const enum libinput_config_tap_button_map button_map = LIBINPUT_CONFIG_TAP_MAP_LRM;

/* If you want to use the windows key for MODKEY, use WLR_MODIFIER_LOGO */
#define MODKEY WLR_MODIFIER_ALT

#define TAGKEYS(KEY,TAG) \
 	{ MODKEY,                    KEY,            view,            {.ui = 1 << TAG} }, \
 	{ MODKEY|WLR_MODIFIER_CTRL,  KEY,            toggleview,      {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_SHIFT, KEY,            tag,             {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_CTRL|WLR_MODIFIER_SHIFT,KEY,toggletag,  {.ui = 1 << TAG} }

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
//#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
// for cahnging the volume via alsa amixer //
static const char *upvol[] = { "amixer", "-q", "-c", "0", "set", "Master", "2+", NULL };
static const char *downvol[] = { "amixer", "-q", "-c", "0", "set", "Master", "2-", NULL };
// for muting/unmuting //
static const char *mute[] = { "amixer", "-q", "set", "Master", "toggle", NULL };
// Other Shit
static const char *termcmd[] = {TERM, NULL};
static const char *roficmd[] = { "bemenu-run", NULL};
static const char *firefoxcmd[] = { BROWSER, NULL};
static const char *newscmd[] = { "foot", "newsboat", NULL};
static const char *audiocmd[] = { "foot", "pulsemixer", NULL};
static const char *statcmd[] = { "foot", "htop", NULL};
static const char *muttcmd[] = { "foot", "neomutt", NULL};
static const char *grim[] = { "grim", "", NULL};

#include "shiftview.c"
#include "keys.h"

static const Key keys[] = {
	/* Note that Shift changes certain key codes: c -> C, 2 -> at, etc. */
	/* modifier                  key                 function        argument */
	{ MODKEY,                    Key_p,          spawn,          { .v = roficmd}},
        { MODKEY,                    Key_w,          spawn,          { .v = firefoxcmd}},
	{ MODKEY|WLR_MODIFIER_SHIFT, Key_Return,     spawn,          { .v = termcmd}},
	{ MODKEY,                    Key_n,          spawn,          { .v = newscmd}},
	{ MODKEY,                    Key_a,          spawn,          { .v = audiocmd}},
	{ MODKEY,                    Key_m,          spawn,          { .v = statcmd}},
	{ MODKEY,                    Key_b,          spawn,          { .v = muttcmd}},
	{ 0,                         Key_Print,          spawn,          { .v = grim}},
	{ MODKEY,                    Key_j,          focusstack,     {.i = +1} },
	{ MODKEY,                    Key_k,          focusstack,     {.i = -1} },
	{ MODKEY,                    Key_i,          incnmaster,     {.i = +1} },
	//{ MODKEY,                    Key_d,          incnmaster,     {.i = -1} },
	{ MODKEY,                    Key_h,          setmfact,       {.f = -0.05} },
	{ MODKEY,                    Key_l,          setmfact,       {.f = +0.05} },
        { MODKEY|WLR_MODIFIER_LOGO,  Key_h,          incgaps,       {.i = +1 } },
	{ MODKEY|WLR_MODIFIER_LOGO,  Key_l,          incgaps,       {.i = -1 } },
	{ MODKEY|WLR_MODIFIER_LOGO|WLR_MODIFIER_SHIFT,   Key_h,      incogaps,      {.i = +1 } },
	{ MODKEY|WLR_MODIFIER_LOGO|WLR_MODIFIER_SHIFT,   Key_l,      incogaps,      {.i = -1 } },
	{ MODKEY|WLR_MODIFIER_LOGO|WLR_MODIFIER_CTRL,    Key_h,      incigaps,      {.i = +1 } },
	{ MODKEY|WLR_MODIFIER_LOGO|WLR_MODIFIER_CTRL,    Key_l,      incigaps,      {.i = -1 } },
	{ MODKEY|WLR_MODIFIER_LOGO,  Key_0,          togglegaps,     {0} },
	{ MODKEY|WLR_MODIFIER_LOGO|WLR_MODIFIER_SHIFT,   Key_parenright,defaultgaps,    {0} },
	{ MODKEY,                    Key_y,          incihgaps,     {.i = +1 } },
	{ MODKEY,                    Key_o,          incihgaps,     {.i = -1 } },
	{ MODKEY|WLR_MODIFIER_CTRL,  Key_y,          incivgaps,     {.i = +1 } },
	{ MODKEY|WLR_MODIFIER_CTRL,  Key_o,          incivgaps,     {.i = -1 } },
	{ MODKEY|WLR_MODIFIER_LOGO,  Key_y,          incohgaps,     {.i = +1 } },
	{ MODKEY|WLR_MODIFIER_LOGO,  Key_o,          incohgaps,     {.i = -1 } },
	{ MODKEY|WLR_MODIFIER_SHIFT, Key_y,          incovgaps,     {.i = +1 } },
	{ MODKEY|WLR_MODIFIER_SHIFT, Key_o,          incovgaps,     {.i = -1 } },
	{ MODKEY,                    Key_Return,     zoom,           {0} },
	{ MODKEY,                    Key_Tab,        view,           {0} },
	{ MODKEY,                    Key_g,          shiftview,      { .i = -1 } },
	{ MODKEY,                    Key_semicolon,  shiftview,      { .i = 1 } },
	{ MODKEY|WLR_MODIFIER_SHIFT, Key_c,          killclient,     {0} },
	{ MODKEY,                    Key_t,          setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                    Key_e,          setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                    Key_q,          setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                    Key_space,      setlayout,      {0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, Key_space,      togglefloating, {0} },
	{ MODKEY,                    Key_f,         togglefullscreen, {0} },
	{ MODKEY,                    Key_0,          view,           {.ui = ~0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, Key_parenright, tag,            {.ui = ~0} },
	{ MODKEY,                    Key_comma,      focusmon,       {.i = WLR_DIRECTION_LEFT} },
	{ MODKEY,                    Key_period,     focusmon,       {.i = WLR_DIRECTION_RIGHT} },
	{ MODKEY|WLR_MODIFIER_SHIFT, Key_less,       tagmon,         {.i = WLR_DIRECTION_LEFT} },
	{ MODKEY|WLR_MODIFIER_SHIFT, Key_grave,    tagmon,         {.i = WLR_DIRECTION_RIGHT} },
	TAGKEYS(          Key_1,                     0),
	TAGKEYS(          Key_2,                         1),
	TAGKEYS(          Key_3,                 2),
	TAGKEYS(          Key_4,                     3),
	TAGKEYS(          Key_5,                    4),
	TAGKEYS(          Key_6,                5),
	TAGKEYS(          Key_7,                  6),
	TAGKEYS(          Key_8,                   7),
	TAGKEYS(          Key_9,                  8),
	{ MODKEY|WLR_MODIFIER_SHIFT, Key_q,          quit,           {0} },

	/* Ctrl-Alt-Backspace and Ctrl-Alt-Fx used to be handled by X server */
        { WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,Key_BackSpace, quit, {0} },
        #define CHVT(KEY,n) { WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT, KEY, chvt, {.ui = (n)} }
	CHVT(Key_F1, 1), CHVT(Key_F2,  2),  CHVT(Key_F3,  3),  CHVT(Key_F4,  4),
	CHVT(Key_F5, 5), CHVT(Key_F6,  6),  CHVT(Key_F7,  7),  CHVT(Key_F8,  8),
	CHVT(Key_F9, 9), CHVT(Key_F10, 10), CHVT(Key_F11, 11), CHVT(Key_F12, 12),
        { 0,XF86XK_AudioRaiseVolume, spawn,{.v = upvol } },
	{ 0,XF86XK_AudioLowerVolume, spawn,{.v = downvol } },
	{ 0,XF86XK_AudioMute,spawn,{.v = mute } },
};

static const Button buttons[] = {
	{ MODKEY, BTN_LEFT,   moveresize,     {.ui = CurMove} },
	{ MODKEY, BTN_MIDDLE, moveresize,     {.ui = Curmfact} },
	{ MODKEY, BTN_RIGHT,  moveresize,     {.ui = CurResize} },
};
