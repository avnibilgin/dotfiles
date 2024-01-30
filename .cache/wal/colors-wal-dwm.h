static const char norm_fg[] = "#afbbe5";
static const char norm_bg[] = "#0E1716";
static const char norm_border[] = "#7a82a0";

static const char sel_fg[] = "#afbbe5";
static const char sel_bg[] = "#2A509B";
static const char sel_border[] = "#afbbe5";

static const char urg_fg[] = "#afbbe5";
static const char urg_bg[] = "#284B91";
static const char urg_border[] = "#284B91";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
