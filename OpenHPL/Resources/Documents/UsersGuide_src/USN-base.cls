%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  LaTeX-class for writing theses  %%
%%                                  %%
%%  (c) Dietmar Winkler (me.dwe.no) %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ---Identification----
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{USN-base}[2018/09/11 Template base class for reports and theses]

% --- definitions of options ---
% norsk option:
\newif\if@norsk
\@norskfalse
\DeclareOption{norsk}{\@norsktrue}

% nosummary option:
\newif\if@summary
\@summarytrue
\DeclareOption{nosummary}{\@summaryfalse}

% All other options are passed on to the book class
\DeclareOption*{%
    \typeout{Option \CurrentOption\space is passed to package scrbook!}
    \PassOptionsToClass{\CurrentOption}{scrbook}
}%

% --- execution of options ---
\ProcessOptions* % process the options in calling order
\LoadClass[12pt, openright]{scrbook}
\KOMAoptions{%
  cleardoublepage=plain,
  parskip=half,
  numbers=noendperiod,
  appendixprefix=true
}

% --- package loading ---
\RequirePackage{scrlayer-scrpage} %% needed for the footer setup
\RequirePackage{geometry}         %% manual set the page size
   \geometry{margin=25mm, includeheadfoot}
\RequirePackage[\if@norsk norsk \else british\fi]{babel}  %% adapt to NO or EN
\RequirePackage{amsmath,mathptmx} %% we need lots of math features
\RequirePackage{ifthen}           %% provides simple if-then functionality
\RequirePackage{url}              %% helps displaying URLs
\RequirePackage{longtable}        %% for long tables that might break over pages
\RequirePackage{graphicx}         %% needed for inclusion of graphics
  \graphicspath{{fig/}}           %% this is were the images reside
\RequirePackage[hidelinks]{hyperref} %% generate links in the PDF (but no boxes around them)
\RequirePackage{pdfpages}         %% for inclusion of PDF documents
\RequirePackage{framed}           %% provides framebox
\RequirePackage[super]{nth}              %% Generate English ordinal numbers
\RequirePackage{lastpage}         %% to calculate the number of pages
\RequirePackage{fontspec}         %% needed to set up custom fonts and lmodern fonts
\RequirePackage{carlito}          %% Carlito is the metric-compatible free alternative
                                  %% to Calibri font
\RequirePackage{csquotes}

% --- set figure and table captions to footnotesize
\setkomafont{caption}{\footnotesize}

% --- set the fonts of all toc entries to san-serif
% from https://tex.stackexchange.com/questions/360135/koma-change-font-of-toc-section-entries
\newcommand*\tocentryformat[1]{{\sffamily#1}}
\RedeclareSectionCommands
  [
    tocentryformat=\tocentryformat,
    tocpagenumberformat=\tocentryformat
  ]
  {section,subsection,subsubsection,paragraph,subparagraph}

% --- useful commands
\newcommand*{\figref}[1]{\figurename~\ref{#1}}
\newcommand*{\tabref}[1]{\tablename~\ref{#1}}

% --- title page setup
\newcommand{\USNlogo}{%            %% lang dependent logo
  \if@norsk%
    \includegraphics[height=15mm]{USN_logo}%
  \else%
    \includegraphics[height=15mm]{USN_logo_en}%
  \fi%
}

\newcommand{\USNtitlehead}{%        %% define the USN title head
  \begin{minipage}[c]{.5\textwidth}%
    \USNlogo%
  \end{minipage}%
  \begin{minipage}[c]{.5\textwidth}%
    \begin{flushright}
      {\sffamily\large\href{http://www.usn.no}{www.usn.no}}
     \end{flushright}
  \end{minipage}%
}
\titlehead{\USNtitlehead}

\publishers{\textsf{%
       \if@norsk%
         {\Large Fakultet for teknologi, naturvitenskap og maritime fag}
       \else%
         {\Large Faculty of Technology, Natural Sciences and Maritime Sciences}
       \fi%
       \\{\large Campus Porsgrunn}}
    }%

%--- special footer setup
% norsk:
\newpagestyle{sammendrag}{}{
 \cfoot{\begin{center}%
     Universitetet i Sørøst-Norge tar ikke ansvar for denne studentrapportens resultater og konklusjoner.
   \end{center}}
}%
% english:
\newpagestyle{summary}{}{
 \cfoot{\begin{center}%
     The University of South-Eastern Norway accepts no responsibility for the results and conclusions presented in this report.
   \end{center}}
}%
