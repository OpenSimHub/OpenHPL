%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  USN-PhD.cls                     %%
%%  LaTeX-class for writing theses  %%
%%                                  %%
%%  (c) Dietmar Winkler (me.dwe.no) %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ---Identification----
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{USN-PhD}[2018/05/04 Template class for PhD theses]

% --- definitions of options ---

% All other options are passed on to the book class
\DeclareOption*{%
    \typeout{Option \CurrentOption\space is passed to package USN-base!}
    \PassOptionsToClass{\CurrentOption}{USN-base}
}%

% --- execution of options ---
\ProcessOptions*      %% process the options in calling order

% --- load other classes
\LoadClass{USN-base}  %% we reuse the USN-base class

% --- useful commands
\newcommand{\mysubject}{Process, Energy and Automation Engineering}

\newcommand{\USNtitlepage}{%
  \subject{\mysubject}
  \title{\mytitle}
  \subtitle{\normalsize
    Thesis submitted to the University of South-Eastern Norway\\
    for the degree of philosophiae doctor~(PhD)}
  \author{\myauthor}
  \date{}
% --- pdf document settings ---
  \hypersetup{%
    pdftitle = {\mytitle},%
    pdfsubject = {\mysubject},%
    pdfauthor = {\myauthor},%
    pdfkeywords = {\mykeywords}
  }%
\pdfbookmark[0]{\@title}{title}    %% set the correct PDF bookmark
\maketitle%
%
\cleardoubleemptypage              %% fillpage without page number
%
}
