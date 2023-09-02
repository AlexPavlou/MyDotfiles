// vertical pixel padding above and below text
static uint32_t vertical_padding = 4;
// allow in-line color commands in status text
static bool status_commands = true;
// font
static char *fontstr = "iosevka:size=14";
// tag names
static char *tags_names[] = { "",  "2", "3", "4"};

// set 16-bit colors for bar
// 8-bit color can be converted to 16-bit color by simply duplicating values e.g
// 0x55 -> 0x5555, 0xf1 -> 0xf1f1
static pixman_color_t active_fg_color = { .red = 0xeeee, .green = 0xeeee, .blue = 0xeeee, .alpha = 0xffff, };
static pixman_color_t active_bg_color = { .red = 0x1d1d, .green = 0x2020, .blue = 0x2121, .alpha = 0xffff, };
static pixman_color_t occupied_fg_color = { .red = 0xeeee, .green = 0xeeee, .blue = 0xeeee, .alpha = 0xffff, };
static pixman_color_t occupied_bg_color = { .red = 0x8080, .green = 0x0000, .blue = 0x8080, .alpha = 0xffff, };
static pixman_color_t inactive_fg_color = { .red = 0xbbbb, .green = 0xbbbb, .blue = 0xbbbb, .alpha = 0xffff, };
static pixman_color_t inactive_bg_color = { .red = 0x1d1d, .green = 0x2020, .blue = 0x2121, .alpha = 0xffff, };
static pixman_color_t urgent_fg_color = { .red = 0x2222, .green = 0x2222, .blue = 0x2221, .alpha = 0xffff, };
static pixman_color_t urgent_bg_color = { .red = 0x1d1d, .green = 0x2020, .blue = 0x2121, .alpha = 0xffff, };
