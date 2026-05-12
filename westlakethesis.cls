\def \wlu@date         {2026-05-12}
\def \wlu@version      {0.0.1}
\def \wlu@maintainerid {myhsia}

\ProvidesExplClass {westlakethesis} {\wlu@date} {\wlu@version}
  {LaTeX Template Bundle for Westlake University}

\PassOptionsToPackage { quiet } { xeCJK }
\LoadClass [ a4paper, zihao = -4, linespread = 1.5, fontset = lxgw ]
  { ctexrep }
\setCJKfamilyfont { zhfs } { FandolFang-Regular }
  [ AutoFakeBold, Extension = .otf ]

\RequirePackage{graphicx, geometry, array, lmodern, microtype, times}
\graphicspath { {./media} }
\RequirePackage[T1]{fontenc}
\RequirePackage{tikz, tikzpagenodes}

% Layout
\geometry{a4paper, hmargin = 1.25in, vmargin = 1in}
\NewDocumentCommand \westlakeset { m }
  {
    \keys_set:nn { @@ / westlakeset } {#1}
    \clist_map_inline:nn { title, school, subject, author, PI }
      { \@@_parse_bilingual:c { l_@@_westlakeset_##1_tl } }
    \str_if_empty:NF \l_@@_westakeset_bib_str
      {
        \RequirePackage[sort, uppercasefamily = false]{gbt7714}
        \setlength \bibhang {-2em}
        \bibliographystyle{gbt7714-numeric}
        \DeclareDocumentCommand \printbibliography {}
          {
            \addcontentsline{toc}{chapter}{参考文献}
            \group_begin:
              \dim_set:Nn \bibsep {1pt}
              \linespread{1.85}\selectfont
              \zihao{5}
              \bibliography { \l_@@_westakeset_bib_str }
            \group_end:
          }
      }
  }

\cs_new:Npn \@@_parse_bilingual:c #1
  {
    \tl_clear_new:c { #1_cn }
    \tl_clear_new:c { #1_en }
    \seq_clear:N \l_@@_westlakeset_tmpa_seq
    \seq_set_split:Nne \l_@@_westlakeset_tmpa_seq { / } { \cs:w #1 \cs_end: }
    \seq_get_left:Nc  \l_@@_westlakeset_tmpa_seq { #1_cn }
    \seq_get_right:Nc \l_@@_westlakeset_tmpa_seq { #1_en }
  }
\seq_clear_new:N \l_@@_westlakeset_tmpa_seq
\cs_generate_variant:Nn \seq_get_left:NN  { Nc }
\cs_generate_variant:Nn \seq_get_right:NN { Nc }

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
\tl_const:Nn \l_@@_westlakeset_affilid_tl { 14626 }
\box_new:N \l_@@_westlakeset_id_box
\box_new:N \l_@@_westlakeset_code_box
\box_new:N \l_@@_westlakeset_en_table_box
\hbox_gset:Nn \l_@@_westlakeset_id_box { 0 }
\hbox_gset:Nn \l_@@_westlakeset_code_box { School ~ Code: }
\hbox_gset:Nn \l_@@_westlakeset_en_table_box { \zihao{3}\sffamily Supervisor: }
\dim_const:Nn \l_@@_westlakeset_id_dim
  { 13 \box_wd:N \l_@@_westlakeset_id_box }
\dim_const:Nn \l_@@_westlakeset_code_dim
  { \box_wd:N \l_@@_westlakeset_code_box }
\dim_const:Nn \l_@@_westlakeset_en_table_dim
  { \box_wd:N \l_@@_westlakeset_en_table_box }
\RenewDocumentCommand \maketitle {}
  {
    \begin{titlepage}
      \group_begin:
      \raggedleft \noindent
      \fangsong
      \linespread{1.0}\selectfont
      \begin{tabular}
        {
          p { 4\ccwd } @{：}
          p \l_@@_westlakeset_id_dim
        }
        \@@_cover_spread_box:nn  { 4\ccwd } { 单位代码                     } &
        \@@_cover_center_box:nnn { \l_@@_westlakeset_id_dim } { -1.5pt }
                                            { \l_@@_westlakeset_affilid_tl }\\
        \@@_cover_spread_box:nn  { 4\ccwd } { 学号                         } &
        \@@_cover_center_box:nnn { \l_@@_westlakeset_id_dim } { -1.5pt }
                                            { \l_@@_westlakeset_id_tl      }\\
      \end{tabular}
      \par \group_end:
      \vspace{1.2\baselineskip}
      \begin{center}
        \includegraphics[height = 1.63cm]{westlake-badge-cn.pdf}
        \par \vspace{.65\baselineskip}
        \LARGE
        \bool_if:NTF \l_@@_westlakeset_master_bool { 硕士 } { 博士 }
        学位论文
        \par \vspace{1.15\baselineskip}
        \group_begin:
          \linespread{1.5}\selectfont \Huge \sffamily
          \parbox { 10\ccwd } { \centering \l_@@_westlakeset_title_tl_cn }
        \group_end:
      \end{center}
      \vspace{4.35\baselineskip}
      \begin{center}
        \zihao{3}\linespread{1.35}\selectfont
        \begin{tabular} { p { 4\ccwd } @{：} p { 15ex } }
          \@@_cover_spread_box:nn  { 4\ccwd } { 培养单位 } &
          \@@_cover_center_box:nnn {  15ex  } { -4.5pt   }
                                   { \prop_item:No \l_@@_westlakeset_cn_prop
                                       { \l_@@_westlakeset_school_tl } }\\
          \@@_cover_spread_box:nn  { 4\ccwd } { 学科     } &
          \@@_cover_center_box:nnn {  15ex  } { -4.5pt   }
                                   { \l_@@_westlakeset_subject_tl_cn   }\\
          \@@_cover_spread_box:nn  { 4\ccwd } { 研究生   } &
          \@@_cover_center_box:nnn {  15ex  } { -4.5pt   }
                                   { \l_@@_westlakeset_author_tl_cn    }\\
          \@@_cover_spread_box:nn  { 4\ccwd } { 指导教师 } &
          \@@_cover_center_box:nnn {  15ex  } { -4.5pt   }
                                   { \l_@@_westlakeset_PI_tl_cn        }\\
        \end{tabular}
        \par\vspace{3.15\baselineskip}
        \zihao{3}
        \zhdigits { \int_use:N \c_sys_year_int  } 年
        \zhdigits { \int_use:N \c_sys_month_int } 月
      \end{center}
    \end{titlepage}
    \begin{titlepage}
      \group_begin:
      \raggedleft \noindent
      \fangsong
      \linespread{1.0}\selectfont
      \begin{tabular}
        {
          p \l_@@_westlakeset_code_dim @{~}
          p \l_@@_westlakeset_id_dim
        }
        School ~ Code: &
        \@@_cover_center_box:nnn { \l_@@_westlakeset_id_dim } { -1.5pt }
                                 { \l_@@_westlakeset_affilid_tl        }\\
        Student ~ ID:  &
        \@@_cover_center_box:nnn { \l_@@_westlakeset_id_dim } { -1.5pt }
                                 { \l_@@_westlakeset_id_tl             }\\
      \end{tabular}
      \par \group_end:
      \vspace{1.2\baselineskip}
      \begin{center}
        \includegraphics[height = 1.63cm]{westlake-badge-en.pdf}
        \par \vspace{2.5\baselineskip}
        \group_begin:
          \linespread{1.3}\selectfont \Huge \sffamily
          \parbox { .9\linewidth }
            {
              \centering \@@_fontsize:n { 20 } \selectfont \bfseries \sffamily
              \l_@@_westlakeset_title_tl_en
            }
        \group_end:
        \par \vspace{1.1\baselineskip}
        \group_begin:
        \zihao{4}\sffamily \bfseries
          (
            Degree ~ of ~
            \bool_if:NTF \l_@@_westlakeset_master_bool { Master } { Doctor }
          )
        \group_end:
      \end{center}
      \vspace{5.15\baselineskip}
      \begin{center}
        \zihao{3}\sffamily \linespread{1.35}\selectfont
        \begin{tabular}
          {
            p \l_@@_westlakeset_en_table_dim @{~}
            p { 15ex }
          }
          School: &
          \@@_cover_center_box:nnn {  15ex  } { -4.8pt   }
                                   { \prop_item:No \l_@@_westlakeset_en_prop
                                       { \l_@@_westlakeset_school_tl } }\\
          Discipline: &
          \@@_cover_center_box:nnn {  15ex  } { -4.8pt   }
                                   { \l_@@_westlakeset_subject_tl_en   }\\
          Candidate: &
          \@@_cover_center_box:nnn {  15ex  } { -4.8pt   }
                                   { \l_@@_westlakeset_author_tl_en    }\\
          Supervisor: &
          \@@_cover_center_box:nnn {  15ex  } { -4.8pt   }
                                   { \l_@@_westlakeset_PI_tl_en        }\\
        \end{tabular}
        \par \vspace{3.9\baselineskip}
        \zihao{3}
        \if_case:w \int_use:N \c_sys_month_int
          \or: January \or: February \or: March
          \or: April   \or: May      \or: June
          \or: July    \or: August   \or: September
          \or: October \or: November \or: December
        \fi:,\space
        \int_value:w \c_sys_year_int
      \end{center}
    \end{titlepage}
  }
\prop_new:N \l_@@_westlakeset_en_prop
\prop_new:N \l_@@_westlakeset_cn_prop
\prop_set_from_keyval:Nn \l_@@_westlakeset_cn_prop
  {
    science     = 理学院,
    sci         = 理学院,
    engineering = 工学院,
    eng         = 工学院,
    sls         = 生命科学学院,
    medicine    = 医学院,
    med         = 医学院,
  }
\prop_set_from_keyval:Nn \l_@@_westlakeset_en_prop
  {
    science     = Science,
    sci         = Science,
    engineering = Engineering,
    eng         = Engineering,
    sls         = Life ~ Sciences,
    medicine    = Medicine,
    med         = Medicine,
  }
\NewDocumentCommand \makespine {}
  {
    \begin{tikzpicture}[remember ~ picture, overlay]
      \node [opacity = .4] at ([xshift = -4.65cm, yshift = .87cm]current ~ page.center)
        {\includegraphics[width = \paperwidth, page = 3]{source/3-研发〔2025〕14号西湖大学研究生学位论文编写指南（附件2-学位论文参考模板）.pdf}};
      \node [minimum ~ width = 2.3cm,        inner ~ sep = 0pt, draw,
             minimum ~ height = \textheight, outer ~ sep = 0pt, right]
            (spine-cn) at (current ~ page ~ text ~ area.west) {};
    \end{tikzpicture}
  }
\RenewDocumentEnvironment {abstract} { O{cn} }
  {
    \tl_set:Nn \l_@@_abstract_language_tl {#1}
    \null \vspace{1.8\baselineskip}
    \@beginparpenalty\@lowpenalty
    \noindent
    \str_case:on {#1}
      {
        { cn } { 摘要：     }
        { en } { Abstract:~ }
      }
    \ignorespaces
  } { \@endparpenalty\@M }
\hook_gput_code:nnn { env / abstract / before } { . }
  { \linespread{1.63}\selectfont }
\NewDocumentCommand \keywords { m }
  {
    \par \noindent
    \str_case:on
      { \l_@@_abstract_language_tl }
      {
        { cn } { 关键词：    \clist_use:nn {#1} { ； } }
        { en } { Keywords: ~ \clist_use:nn {#1} { ;~ } }
      }
  }

\ctex_set:n
  {
    chapter =
      {
        format+    = \zihao{3} \sffamily \mdseries,
        number     = \arabic{chapter}, fixskip,
        beforeskip = 40pt, afterskip = 30pt,
        aftername  = \enspace,
      },
    section =
      {
        format+ = \zihao{4} \sffamily \mdseries \raggedright,
        fixskip,
        beforeskip = 18pt, afterskip = 15pt,
        aftername = \enspace,
      },
    subsection =
      {
        format+ = \@@_fontsize:n { 13 } \sffamily \mdseries \raggedright,
        fixskip,
        beforeskip = 15.5pt, afterskip = 13.5pt,
        aftername = \quad,
      },
    subsubsection =
      {
        format+ = \zihao{ -4 } \sffamily \mdseries \raggedright,
        fixskip,
        beforeskip = 13pt, afterskip = 12pt,
        aftername = \quad,
      },
    contentsname = 目\quad 录, secnumdepth = 3,
  }

% Functions
\cs_new_protected:Npn \@@_cover_spread_box:nn #1#2
  {
    \mode_leave_vertical:
    \hbox_to_wd:nn {#1}
    { \exp_args:Nee \tl_map_inline:nn {#2} { ##1 \hfil } \unskip }
  }

\cs_new_protected:Npn \@@_cover_center_box:nnn #1#2#3
  {
    \mode_leave_vertical:
    \dim_set:Nn \l_tmpa_dim {#1}
    \box_gset_eq_drop:NN 1\voidb@x
    \group_begin:
    \vbox_set:Nn 0
      {
        \dim_set:Nn  \parindent   { 0pt            }
        \skip_set:Nn \leftskip    { 0pt plus 1fil  }
        \skip_set:Nn \rightskip   { 0pt plus -1fil }
        \skip_set:Nn \parfillskip { 0pt plus 2fil  }
        #3 \par
        \loop
        \box_set_to_last:N 2
        \reverse_if:N \if_box_empty:N 2
        \vbox_gset_top:Nn 1
          {
            \hbox_to_wd:nn {#1} { \strut \hbox_unpack_drop:N 2 }
            \skip_vertical:n {#2} \__box_rule_horizontal:nn { .5pt } { 0pt }
            \skip_vertical:n { 9.6pt } \vbox_unpack_drop:N 1
          }
        \unskip \unpenalty
        \repeat
      }
    \group_end:
    \tex_box:D 1
  }
\cs_new_nopar:Npn \@@_fontsize:n #1
  { \fontsize {#1} { \fp_eval:n { #1 * 6 / 5 }} \selectfont }

\file_input_stop: