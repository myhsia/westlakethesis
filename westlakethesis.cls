\def \wlu@date         {2026-05-12}
\def \wlu@version      {0.0.1}
\def \wlu@maintainerid {myhsia}
\ProvidesExplClass {westlakethesis} {\wlu@date} {\wlu@version}
  {LaTeX Template Bundle for Westlake University}

\cs_new_protected:Npn \@@_msg_new:nn #1#2
  { \msg_new:nnn     { WestlakeThesis } {#1} {#2} }
\cs_new_protected:Npn \@@_msg_error:nn #1#2
  { \msg_error:nnn   { WestlakeThesis } {#1} {#2} }
\cs_new_protected:Npn \@@_msg_warning:nn #1#2
  { \msg_warning:nnn { WestlakeThesis } {#1} {#2} }
\cs_new_protected:Npn \@@_msg_info:nn #1#2
  { \msg_info:nnn    { WestlakeThesis } {#1} {#2} }
\@@_msg_new:nn { not found module }
  { The ~ WestlakeThesis ~ module ~ `#1' ~ not ~ found. }
\cs_new_protected_nopar:Npn \@@_load_module:n #1
  {
    \clist_map_inline:nn {#1}
      {
        \file_if_exist_input:nF { wlu-##1.code.tex }
          { \@@_msg_error:nn { not found module } { ##1 } }
      }
  }
\cs_new_protected_nopar:Npn \@@_provide_module:n #1
  {
    \ProvidesExplFile { wlu-#1.code.tex} { \wlu@date } { \wlu@version }
      {WestlakeThesis ~ \text_titlecase:n {#1} ~ Module}
  }

\@@_load_module:n { driver, kernel, params, layout, }

\@onlypreamble \westlakeset
\NewDocumentCommand \westlakeset { m }
  {
    \keys_set:nn { @@ / westlakeset } {#1}
    \clist_map_inline:nn { title, school, subject, author, PI }
      { \@@_parse_slash_ab:c { l_@@_westlakeset_##1_tl } }
    \str_if_empty:NF \l_@@_westakeset_bib_str
      { \bool_gset_true:N \l_@@_load_bib_bool }
  }
\keys_define:nn { @@ / westlakeset }
  {
    id        .tl_set:N   = \l_@@_westlakeset_id_tl,
      id      .initial:n  = { \int_value:w \c_sys_year_int 0000000 },
    title     .tl_set:N   = \l_@@_westlakeset_title_tl,
    school    .tl_set:N   = \l_@@_westlakeset_school_tl,
    subject   .tl_set:N   = \l_@@_westlakeset_subject_tl,
    author    .tl_set:N   = \l_@@_westlakeset_author_tl,
    PI        .tl_set:N   = \l_@@_westlakeset_PI_tl,
    master    .bool_set:N = \l_@@_westlakeset_master_bool,
      master  .initial:n  = false,
      master  .default:n  = true,
    bibsource .str_set:N  = \l_@@_westakeset_bib_str,
  }

\file_input_stop: