%%
%% This is file `westlakethesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% westlakethesis.dtx  (with options: `wlu-class')
%% -----------------------------------------------------------------------
%%   Copyright (C) 2026 by Mingyu Xia <myhsia@outlook.com>               *
%% -----------------------------------------------------------------------
%%   This work may be distributed and/or modified under the conditions   *
%%   of the LaTeX Project Public License (LPPL), either version 1.3c of  *
%%   this license or (at your option) any later version.                 *
%%   The latest version of this license is in                            *
%%                                                                       *
%%       http://www.latex-project.org/lppl.txt                           *
%%                                                                       *
%%   and version 1.3c or later is part of all distributions of LaTeX     *
%%   version 2008 or later.                                              *
%%                                                                       *
%%   This work has the LPPL maintenance status `maintained'.             *
%%                                                                       *
%%   The Current Maintainer of this work is Mingyu Xia.                  *
%% -----------------------------------------------------------------------
\def \wlu@date         {2026-05-12}
\def \wlu@version      {0.0.1}
\def \wlu@maintainerid {myhsia}
\ProvidesExplClass {westlakethesis} {\wlu@date} {\wlu@version}
  {LaTeX Template Bundle for Westlake University}
\cs_new_protected:Npn \__wlu_msg_new:nn #1#2
  { \msg_new:nnn     { WestlakeThesis } {#1} {#2} }
\cs_new_protected:Npn \__wlu_msg_error:nn #1#2
  { \msg_error:nnn   { WestlakeThesis } {#1} {#2} }
\cs_new_protected:Npn \__wlu_msg_warning:nn #1#2
  { \msg_warning:nnn { WestlakeThesis } {#1} {#2} }
\cs_new_protected:Npn \__wlu_msg_info:nn #1#2
  { \msg_info:nnn    { WestlakeThesis } {#1} {#2} }
\__wlu_msg_new:nn { not found module }
  { The ~ WestlakeThesis ~ module ~ `#1' ~ not ~ found. }
\cs_new_protected_nopar:Npn \__wlu_load_module:n #1
  {
    \clist_map_inline:nn {#1}
      {
        \file_if_exist_input:nF { wlu-##1.code.tex }
          { \__wlu_msg_error:nn { not found module } { ##1 } }
      }
  }
\cs_new_protected_nopar:Npn \__wlu_provide_module:n #1
  {
    \ProvidesExplFile { wlu-#1.code.tex} { \wlu@date } { \wlu@version }
      {WestlakeThesis ~ \text_titlecase:n {#1} ~ Module}
  }
\__wlu_load_module:n { driver, kernel, params, layout, }
\@onlypreamble \westlakeset
\NewDocumentCommand \westlakeset { m }
  {
    \keys_set:nn { __wlu / westlakeset } {#1}
    \clist_map_inline:nn { title, school, subject, author, PI }
      { \__wlu_parse_slash_ab:c { l__wlu_westlakeset_##1_tl } }
    \str_if_empty:NF \l__wlu_westakeset_bib_str
      { \bool_gset_true:N \l__wlu_load_bib_bool }
  }
\keys_define:nn { __wlu / westlakeset }
  {
    id        .tl_set:N   = \l__wlu_westlakeset_id_tl,
      id      .initial:n  = { \int_value:w \c_sys_year_int 0000000 },
    title     .tl_set:N   = \l__wlu_westlakeset_title_tl,
    school    .tl_set:N   = \l__wlu_westlakeset_school_tl,
    subject   .tl_set:N   = \l__wlu_westlakeset_subject_tl,
    author    .tl_set:N   = \l__wlu_westlakeset_author_tl,
    PI        .tl_set:N   = \l__wlu_westlakeset_PI_tl,
    master    .bool_set:N = \l__wlu_westlakeset_master_bool,
      master  .initial:n  = false,
      master  .default:n  = true,
    bibsource .str_set:N  = \l__wlu_westakeset_bib_str,
  }
\file_input_stop:
%% -----------------------------------------------------------------------
%%   This work consists of the files westlakethesis.dtx,                 *
%%                                   westlakethesis.ins,                 *
%%                 the derived files westlakethesis.cls,                 *
%%                                   wlu-driver.code.tex,                *
%%                                   wlu-kernel.code.tex,                *
%%                                   wlu-params.code.tex,                *
%%                                   wlu-layout.code.tex,                *
%%           the documentation files westlakethesis.pdf,                 *
%%                               and README.md.                          *
%% -----------------------------------------------------------------------
%%
%% End of file `westlakethesis.cls'.
