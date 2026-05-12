\def \wlu@date         {2026-05-12}
\def \wlu@version      {0.0.1}
\def \wlu@maintainerid {myhsia}

\ProvidesExplClass{westlakethesis}{\wlu@date}{\wlu@version}
  {LaTeX Template Bundle for Westlake University}

\LoadClass[a4paper, zihao = -4, fontset = fandol]{ctexrep}

\RequirePackage{graphicx, geometry, array, lmodern, times}
\graphicspath{{./media}}
\RequirePackage[T1]{fontenc}
\geometry{a4paper, hmargin = 1.25in, vmargin = 1in}

% Layout
\NewDocumentCommand \westlakeset { m }
  { \keys_set:nn { @@ / westlakeset } {#1} }
\seq_new:N \l_@@_westlakeset_tmpa_seq
\cs_new:Npn \@@_parse_bilingual:Nn #1#2
  {
    \seq_set_split:Nne \l_@@_westlakeset_tmpa_seq { / } #1
    \seq_item:Nn \l_@@_westlakeset_tmpa_seq {#2}
    \seq_clear:N \l_@@_westlakeset_tmpa_seq
  }
\keys_define:nn { @@ / westlakeset }
  {
    id      .tl_set:N    = \l_@@_westlakeset_id_tl,
      id    .initial:n   = { \int_value:w \c_sys_year_int 0000000 },
    title   .tl_set:N    = \l_@@_westlakeset_title_tl,
    school  .tl_set:N    = \l_@@_westlakeset_school_tl,
    subject .tl_set:N    = \l_@@_westlakeset_subject_tl,
    author  .tl_set:N    = \l_@@_westlakeset_author_tl,
    PI      .tl_set:N    = \l_@@_westlakeset_PI_tl,
    master  .bool_set:N  = \l_@@_westlakeset_master_bool,
      master.initial:n   = false,
      master.default:n   = true,
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
      \begingroup
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
      \par \endgroup
      \vspace{1.4\baselineskip}
      \begin{center}
        \includegraphics[height = 1.63cm]{westlake-badge-cn.pdf}
        \par \vspace{\baselineskip}
        \LARGE
        \bool_if:NTF \l_@@_westlakeset_master_bool { 硕士 } { 博士 }
        学位论文
        \par \vspace{1.3\baselineskip}
        \begingroup
          \linespread{1.5}\selectfont \Huge \sffamily
          \parbox { 10\ccwd }
            {
              \centering
              \@@_parse_bilingual:Nn \l_@@_westlakeset_title_tl { 1 }
            }
        \endgroup
      \end{center}
      \vspace{5.1\baselineskip}
      \begin{center}
        \zihao{3}\linespread{1.35}\selectfont
        \begin{tabular} { p { 4\ccwd } @{：} p { 15ex } }
          \@@_cover_spread_box:nn  { 4\ccwd } { 培养单位 } &
          \@@_cover_center_box:nnn {  15ex  } { -4.5pt   }
                                   { \prop_item:No \l_@@_westlakeset_cn_prop
                                       { \l_@@_westlakeset_school_tl }       }\\
          \@@_cover_spread_box:nn  { 4\ccwd } { 学科     } &
          \@@_cover_center_box:nnn {  15ex  } { -4.5pt   }
            { \@@_parse_bilingual:Nn \l_@@_westlakeset_subject_tl { 1 }      }\\
          \@@_cover_spread_box:nn  { 4\ccwd } { 研究生   } &
          \@@_cover_center_box:nnn {  15ex  } { -4.5pt   }
            { \@@_parse_bilingual:Nn \l_@@_westlakeset_author_tl  { 1 }      }\\
          \@@_cover_spread_box:nn  { 4\ccwd } { 指导教师 } &
          \@@_cover_center_box:nnn {  15ex  } { -4.5pt   }
            { \@@_parse_bilingual:Nn \l_@@_westlakeset_PI_tl      { 1 }      }\\
        \end{tabular}
        \par\vspace{3.15\baselineskip}
        \zihao{3}
        \zhdigits { \int_use:N \c_sys_year_int  } 年
        \zhdigits { \int_use:N \c_sys_month_int } 月
      \end{center}
    \end{titlepage}
    \begin{titlepage}
      \begingroup
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
      \par \endgroup
      \vspace{1.3\baselineskip}
      \begin{center}
        \includegraphics[height = 1.63cm]{westlake-badge-en.pdf}
        \par \vspace{3\baselineskip}
        \begingroup
          \linespread{1.55}\selectfont \Huge \sffamily
          \parbox { .9\linewidth }
            {
              \centering \fontsize{20}{20}\selectfont \bfseries \sffamily
              \@@_parse_bilingual:Nn \l_@@_westlakeset_title_tl { 2 }
            }
        \endgroup
        \par \vspace{1.2\baselineskip}
        \begingroup
        \zihao{4}\sffamily \bfseries
          (
            Degree ~ of ~
            \bool_if:NTF \l_@@_westlakeset_master_bool { Master } { Doctor }
          )
        \endgroup
      \end{center}
      \vspace{6\baselineskip}
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
                                       { \l_@@_westlakeset_school_tl }       }\\
          Discipline: &
          \@@_cover_center_box:nnn {  15ex  } { -4.8pt   }
            { \@@_parse_bilingual:Nn \l_@@_westlakeset_subject_tl { 2 }      }\\
          Candidate: &
          \@@_cover_center_box:nnn {  15ex  } { -4.8pt   }
            { \@@_parse_bilingual:Nn \l_@@_westlakeset_author_tl  { 2 }      }\\
          Supervisor: &
          \@@_cover_center_box:nnn {  15ex  } { -4.8pt   }
            { \@@_parse_bilingual:Nn \l_@@_westlakeset_PI_tl      { 2 }      }\\
        \end{tabular}
        \par \vspace{3.85\baselineskip}
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
    \global\setbox1 = \box\voidb@x
    \group_begin:
    \setbox0 = \vbox
      {
        \dim_set:Nn  \hsize       {#1}\relax
        \dim_set:Nn  \parindent   {0pt}
        \skip_set:Nn \leftskip    {0pt plus 1fil}
        \skip_set:Nn \rightskip   {0pt plus -1fil}
        \skip_set:Nn \parfillskip {0pt plus 2fil}
        #3 \par
        \loop
        \setbox2 = \lastbox
        \unless\ifvoid2
        \global\setbox1 = \vtop
          {
            \hbox to\hsize{\strut\unhbox2}
            \vskip#2 \hrule height .5pt
            \vskip9.6pt \unvbox1
          }
        \unskip\unpenalty
        \repeat
      }
    \group_end:
    \box1
  }

\file_input_stop: