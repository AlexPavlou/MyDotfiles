/* See LICENSE file for copyright and license details. */

/* Constants */
#define TERMINAL "st"
#define TERMCLASS "St"
#define BROWSER "firefox-bin"

/* appearance */
static unsigned int borderpx  = 3;        /* border pixel of windows */
static unsigned int snap      = 32;       /* snap pixel */
static unsigned int gappih    = 20;       /* horiz inner gap between windows */
static unsigned int gappiv    = 10;       /* vert inner gap between windows */
static unsigned int gappoh    = 10;       /* horiz outer gap between windows and screen edge */
static unsigned int gappov    = 30;       /* vert outer gap between windows and screen edge */
static int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static int showbar            = 1;        /* 0 means no bar */
static int topbar             = 1;        /* 0 means bottom bar */
static const int vertpad            = 3;       /* vertical padding of bar */
static const int sidepad            = 3;       /* horizontal padding of bar */
static const int CORNER_RADIUS = 6;
static const int tag_preview        = 0;        /* 1 means enable, 0 is off */
static const int colorfultag        = 1;        /* 0 means use SchemeSel for selected non vacant tag */
static const int horizpadbar        = 4;        /* horizontal padding for statusbar, why 4? well it works */
static const int vertpadbar         = 4;      /* vertical padding for statusbar */
static const char *fonts[]          = {"iosevka:size=15", "Hack Nerd Font:size=14"};
static const char dmenufont[]       = "iosevka:size=15";

// theme
#include "themes/gruvbox.h"

static const char *colors[][3]      = {
    /*                     fg       bg      border */
    [SchemeNorm]       = { white,   black,  gray2 },
    [SchemeSel]        = { gray4,   blue,   purple},
    [SchemeTitle]      = { white,   black,  white  }, // active window title
    [TabSel]           = { blue,    gray2,  black },
    [TabNorm]          = { gray3,   black,  black },
    [SchemeTag]        = { gray3,   black,  black },
    [SchemeTag1]       = { black,   purple,   purple  },
    [SchemeTag2]       = { red,     black,  black },
    [SchemeTag3]       = { orange,  black,  black },
    [SchemeTag4]       = { green,   black,  black },
    [SchemeTag5]       = { pink,    black,  black },
    [SchemeTag6]       = { cyan,    black,  black },
    [SchemeTag7]       = { white,    black,  black },
    [SchemeTag8]       = { yellow,    black,  black },
    [SchemeTag9]       = { gold,    black,  black },
    [SchemeLayout]     = { green,   black,  black },
    [SchemeLayout]     = { green,   black,  black },
    [SchemeLayout]     = { green,   black,  black },
    [SchemeLayout]     = { green,   black,  black },
    [SchemeLayout]     = { green,   black,  black },
    [SchemeBtnPrev]    = { green,   black,  black },
    [SchemeBtnNext]    = { yellow,  black,  black },
    [SchemeBtnClose]   = { red,     black,  black },
};

static const int tagschemes[] = {
    SchemeTag1, SchemeTag2, SchemeTag3, SchemeTag4, SchemeTag5, SchemeTag6, SchemeTag7, SchemeTag8, SchemeTag9,
};

typedef struct {
	const char *name;
	const void *cmd;
} Sp;
/* const char *spcmd1[] = {TERMINAL, "-n", "spterm", "-g", "120x34", NULL }; */
const char *spcmd1[] = {TERMINAL, "-n", "spterm", "-g", "400x200", NULL };

/* tagging */
static const char *tags[] = { "",  "", "", "", "", "", "", "", "" };

static const unsigned int ulinepad	= 5;	/* horizontal padding between the underline and tag */
static const unsigned int ulinestroke	= 2;	/* thickness / height of the underline */
static const unsigned int ulinevoffset	= 0;	/* how far above the bottom of the bar the line should appear */
static const int ulineall 		= 0;	/* 1 to show underline on all tags, 0 for just the active ones */

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	*/
	/* class    instance      title       	 tags mask    isfloating   isterminal  noswallow  monitor */
	{ "Gimp",     NULL,       NULL,       	    1 << 8,       0,           0,         0,        -1 },
	{ TERMCLASS,  NULL,       NULL,       	    0,            0,           1,         0,        -1 },
	{ "Firefox",  NULL,       NULL,       	    1 << 8,       0,           -1 },
};

/* layout(s) */
static float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static int nmaster     = 1;    /* number of clients in master area */
static int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "ﱖ",	tile },			/* Default: Master on left, slaves on right */
	{ "TTT",	bstack },		/* Master on top, slaves on bottom */
	{ "[@]",	spiral },		/* Fibonacci spiral */
	{ "[\\]",	dwindle },		/* Decreasing in size right and leftward */
	{ "[D]",	deck },			/* Master on left, slaves in monocle-like mode on right */
	{ "|M|",	centeredmaster },		/* Master in middle, slaves on sides */
	{ ">M>",	centeredfloatingmaster },	/* Same but master floats */
	{ "><>",	NULL },			/* no layout function means floating behavior */
	{ NULL,		NULL },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* commands */

/*static char dmenumon[2] = "0";  component of dmenucmd, manipulated in spawn()
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", black , "-nf", white , "-sb", blue , "-sf", white , NULL };*/

static const char *roficmd[] = { "rofi", "-show", "drun", "-show-icons", NULL };

static const char *termcmd[]  = { TERMINAL, NULL };
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

#include <X11/XF86keysym.h>
#include "shiftview.c"

static Key keys[] = {
	/* modifier                     key        function        argument */
        { MODKEY, XK_F5, spawn, SHCMD("setxkbmap us") },
        { MODKEY, XK_F6, spawn, SHCMD("setxkbmap gr") },
	{ MODKEY,		XK_grave,	spawn,	{.v = (const char*[]){ "dmenuunicode", NULL } } },
	{ MODKEY,                       XK_p,      spawn,          {.v = roficmd} },
	{ MODKEY|ShiftMask,     XK_Return, spawn,   {.v = termcmd } },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	TAGKEYS(			XK_1,		0)
	TAGKEYS(			XK_2,		1)
	TAGKEYS(			XK_3,		2)
	TAGKEYS(			XK_4,		3)
	TAGKEYS(			XK_5,		4)
	TAGKEYS(			XK_6,		5)
	TAGKEYS(			XK_7,		6)
	TAGKEYS(			XK_8,		7)
	TAGKEYS(			XK_9,		8)
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,			XK_0,		view,		{.ui = ~0 } },
	{ MODKEY|ShiftMask,		XK_0,		tag,		{.ui = ~0 } },
	{ MODKEY|ShiftMask, 	        XK_q,      	quit,            {0}},
	{ MODKEY,			XK_w,		spawn,		{.v = (const char*[]){ BROWSER, NULL } } },
	{ MODKEY,			XK_o,		incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,		XK_o,		incnmaster,     {.i = -1 } },
	{ MODKEY,			XK_backslash,		view,		{0} },
	/* { MODKEY|ShiftMask,		XK_backslash,		spawn,		SHCMD("") }, */
	/* { MODKEY|ShiftMask,		XK_s,		spawn,		SHCMD("") }, */
	{ MODKEY|ShiftMask,		XK_d,		spawn,		{.v = (const char*[]){ "passmenu", NULL } } },
	{ MODKEY,			XK_f,		togglefullscr,	{0} },
	{ MODKEY,			XK_h,		setmfact,	{.f = -0.05} },
	/* J and K are automatically bound above in STACKEYS */
	{ MODKEY,			XK_l,		setmfact,      	{.f = +0.05} },
	{ MODKEY,			XK_g,		shiftview,	{ .i = -1 } },
	{ MODKEY,			XK_semicolon,	shiftview,	{ .i = 1 } },
	{ MODKEY|ShiftMask,		XK_Page_Up,	shifttag,	{ .i = -1 } },
	{ MODKEY,			XK_z,		incrgaps,	{.i = +3 } },
	{ MODKEY,			XK_x,		incrgaps,	{.i = -3 } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,			XK_Left,	focusmon,	{.i = -1 } },
	{ MODKEY|ShiftMask,		XK_Left,	tagmon,		{.i = -1 } },
    { MODKEY,			XK_t,		setlayout,	{.v = &layouts[0]} }, /* tile */
	{ MODKEY|ShiftMask,		XK_t,		setlayout,	{.v = &layouts[1]} }, /* bstack */
	{ MODKEY,			XK_y,		setlayout,	{.v = &layouts[2]} }, /* spiral */
	{ MODKEY|ShiftMask,		XK_y,		setlayout,	{.v = &layouts[3]} }, /* dwindle */
	{ MODKEY,			XK_u,		setlayout,	{.v = &layouts[4]} }, /* deck */
	{ MODKEY,			XK_i,		setlayout,	{.v = &layouts[6]} }, /* centeredmaster */
	{ MODKEY|ShiftMask,		XK_i,		setlayout,	{.v = &layouts[7]} }, /* centeredfloatingmaster */
	{ MODKEY|ShiftMask,		XK_f,		setlayout,	{.v = &layouts[8]} },
	{ MODKEY,			XK_Right,	focusmon,	{.i = +1 } },
	{ MODKEY|ShiftMask,		XK_Right,	tagmon,		{.i = +1 } },

	/*{ MODKEY,			XK_F8,		spawn,		{.v = (const char*[]){ "mw", "-Y", NULL } } },
	{ MODKEY,			XK_F9,		spawn,		{.v = (const char*[]){ "dmenumount", NULL } } },
	{ MODKEY,			XK_F10,		spawn,		{.v = (const char*[]){ "dmenuumount", NULL } } },*/
	{ MODKEY|ShiftMask,		XK_space,	togglefloating,	{0} },
  { MODKEY,			XK_a,		spawn,		{.v = (const char*[]){ TERMINAL, "-e", "pulsemixer", NULL } } },
	{ MODKEY,			XK_b,		spawn,		{.v = (const char*[]){ TERMINAL, "-e", "neomutt", NULL } } },
	{ MODKEY,			XK_n,		spawn,		{.v = (const char*[]){ TERMINAL, "-e", "newsboat", NULL } } },
	{ MODKEY,			XK_m,		spawn,		{.v = (const char*[]){ TERMINAL, "-e", "htop", NULL } } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
    { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	{ ClkTagBar,		0,		Button4,	shiftview,	{.i = -1} },
	{ ClkTagBar,		0,		Button5,	shiftview,	{.i = 1} },
};
