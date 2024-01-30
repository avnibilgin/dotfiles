const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0E1716", /* black   */
  [1] = "#284B91", /* red     */
  [2] = "#2A509B", /* green   */
  [3] = "#3057A9", /* yellow  */
  [4] = "#4F67AF", /* blue    */
  [5] = "#5473C9", /* magenta */
  [6] = "#8A739D", /* cyan    */
  [7] = "#afbbe5", /* white   */

  /* 8 bright colors */
  [8]  = "#7a82a0",  /* black   */
  [9]  = "#284B91",  /* red     */
  [10] = "#2A509B", /* green   */
  [11] = "#3057A9", /* yellow  */
  [12] = "#4F67AF", /* blue    */
  [13] = "#5473C9", /* magenta */
  [14] = "#8A739D", /* cyan    */
  [15] = "#afbbe5", /* white   */

  /* special colors */
  [256] = "#0E1716", /* background */
  [257] = "#afbbe5", /* foreground */
  [258] = "#afbbe5",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
