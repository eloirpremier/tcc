%==============================================================================
% setrem - classe de documento com padres da SETREM
% $Id: setrem.cls,v 1.0.0 2011/11/27 $
%==============================================================================

%==============================================================================
% Classe baseada em:
%
% iiufrgs - classe de documento com padres do II/UFRGS
% $Id: iiufrgs.cls,v 4.17 2005/01/14 19:12:24 avila Exp $
%
% Copyright (C) 2001-2005 UFRGS TeX Users Group
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%
% UFRGS TeX Users Group
% Institute of Informatics --- UFRGS
% Porto Alegre, Brazil
% http://www.inf.ufrgs.br/utug
% Discussion list: utug-l@inf.ufrgs.br
%==============================================================================

%==============================================================================
% Identificao
%==============================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{setrem}[2011/11/27 v1.0.0 Formatacao de documentos para a SETREM]

%==============================================================================
% Declarao de opes
%==============================================================================
\newcommand{\iiu@novodoc}[1]{%
		\DeclareOption{#1}{\AtEndOfClass{\input{template/#1.def}}}
}%

\iiu@novodoc{rp}
\iiu@novodoc{prop-tese}
\iiu@novodoc{plano-doutorado}
\iiu@novodoc{dipl}
\iiu@novodoc{ti}
\iiu@novodoc{pep}
\iiu@novodoc{diss}
\iiu@novodoc{tese}
\iiu@novodoc{tc}
\iiu@novodoc{espec}
\iiu@novodoc{formais}
\DeclareOption{english}{\@englishtrue\OptionNotUsed}\newif\if@english
\DeclareOption{oneside}{\AtEndOfClass{\@twosidefalse}\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

%==============================================================================
% Herana da classe `report' e incluso de pacotes e arquivos necessrios
%==============================================================================
%\RequirePackage[a4paper]{geometry}
\LoadClass[12pt,twoside]{report}
\special{papersize=210mm,297mm}
%\RequirePackage[papersize=210mm,297mm]{geometry}
%\RequirePackage[pass,paperwidth=210mm,paperheight=297mm]{geometry}

\RequirePackage[english,brazilian]{babel}
\input{template/brazilian.babel}
\input{template/english.babel}
\if@english
    \selectlanguage{english}
    \AtBeginDocument{\selectlanguage{english}}
\fi
\RequirePackage{lastpage}
\RequirePackage{indentfirst}
\RequirePackage{natbib}
\RequirePackage{template/setremdefs}
\RequirePackage{setspace}
\RequirePackage{titlesec}
\RequirePackage{ragged2e}




%%% These lines test for star and number of arguments 
%%% and call the workhorses below
%
% Test for star (mid-sentence and start-sentence forms)
\def\citep{\citepnostar}

%
% No star found. Now test for argument count.
\def\citepnostar%
    {\@ifnextchar[{\squarecitep}{\simplecitep}}
\def\squarecitep[#1]%
    {\@ifnextchar[{\twocitep[#1]}{\onecitep[#1]}}

%%% The following actually do the \cite work
%
% The \citep cases (no arg, one arg, and two args)
\def\simplecitep#1%
    {\Citep*{#1}}
\def\onecitep[#1]#2%
    {\Citep*[#1]{#2}}
\def\twocitep[#1][#2]#3%
    {(\Citeauthor*{#3}, \citeyear[#1][#2]{#3})}


%==============================================================================
% Fonte
%==============================================================================
\RequirePackage[T1]{fontenc}
\RequirePackage{helvet}
\renewcommand{\familydefault}{\sfdefault}
\RequirePackage{blindtext}

\RequirePackage[justification=justified,singlelinecheck=false]{caption}

%==============================================================================
% Texto
%==============================================================================
% Texto justificado
\justifying

% Identao
\parindent 1.5cm

% Espao entre pargrafos
\parskip 18pt

% Espao entre linhas
\setstretch{1.5}

%==============================================================================
% Margens do texto
%==============================================================================
% Margem superior de 2cm antes da paginao
\setlength{\topmargin}{2cm}
        \addtolength{\topmargin}{-1in}

% Mais 1cm depois da paginao
% Totalizando 3cm de borda superior
\setlength{\headsep}{1cm}
        
% Todo o resto com 0cm
\setlength{\headheight}{0cm}
\setlength{\footskip}{0cm}

% Altura da pgina, removendo 5cm (3cm superior, 2cm inferior)
\setlength{\textheight}{\paperheight}
        \addtolength{\textheight}{-3.3cm}

% Margem esquerda de 3cm para pginas pares e mpares
\setlength{\oddsidemargin}{-1in}
        \addtolength{\oddsidemargin}{3cm}
\setlength{\evensidemargin}{\oddsidemargin}

% Largura da pgina, removendo 5cm (3cm da esquerda, 2cm da direita)
\setlength{\textwidth}{\paperwidth}
        \addtolength{\textwidth}{-5.6cm}

%==============================================================================
% Numerao das pginas
%==============================================================================
\def\ps@setrem{
        \let\@oddfoot\@empty
        \let\@evenfoot\@empty
        \def\@evenhead{\hspace*{\fill}{\@setfontsize\normalsize{10pt}{20}\thepage}}
        \def\@oddhead{\hspace*{\fill}{\@setfontsize\normalsize{10pt}{20}\thepage}}
}
\pagestyle{empty}
\let\ps@plain\ps@empty

%==============================================================================
% Definio de autor(es), orientador e co-orientador
%==============================================================================
\newcounter{ii@authorcount}
\renewcommand{\author}[2]{
        \addtocounter{ii@authorcount}{1}
        \expandafter\gdef\csname @author\alph{ii@authorcount}last\endcsname{#1}
        \expandafter\gdef\csname @author\alph{ii@authorcount}first\endcsname{#2}
        \expandafter\gdef\csname @author\alph{ii@authorcount}\endcsname{#2 #1}
}
\DeclareRobustCommand{\advisor}[3][]{
        \gdef\@advisorlast{#2}
        \gdef\@advisorfirst{#3}
        \gdef\@advisor{#1~#3 #2}
}
\DeclareRobustCommand{\coadvisor}[3][]{
        \gdef\@coadvisorlast{#2}
        \gdef\@coadvisorfirst{#3}
        \gdef\@coadvisor{#1~#3 #2}
}

%==============================================================================
% Definio do Departamento relacionado ao documento
% deve ser definido como `ina' ou `int'
%==============================================================================
\newcommand{\dept}[1]{\gdef\@dept{#1}}

%==============================================================================
% Definio das palavras-chave (mx. 10)
%==============================================================================
\newcounter{kwcounter}
\newcommand{\keyword}[1]{
        \addtocounter{kwcounter}{1}
        \expandafter\gdef\csname keyw\alph{kwcounter}\endcsname{#1}
}

\newcommand{\@cipkw}{%
        \@ifundefined{keywa}{}{1.~\expandafter\MakeUppercase\keywa\@. }%
        \@ifundefined{keywb}{}{2.~\expandafter\MakeUppercase\keywb\@. }%
        \@ifundefined{keywc}{}{3.~\expandafter\MakeUppercase\keywc\@. }%
        \@ifundefined{keywd}{}{4.~\expandafter\MakeUppercase\keywd\@. }%
        \@ifundefined{keywe}{}{5.~\expandafter\MakeUppercase\keywe\@. }%
        \@ifundefined{keywf}{}{6.~\expandafter\MakeUppercase\keywf\@. }%
        \@ifundefined{keywg}{}{7.~\expandafter\MakeUppercase\keywg\@. }%
        \@ifundefined{keywh}{}{8.~\expandafter\MakeUppercase\keywh\@. }%
        \@ifundefined{keywi}{}{9.~\expandafter\MakeUppercase\keywi\@. }%
        \@ifundefined{keywj}{}{10.~\expandafter\MakeUppercase\keywj\@. }%
}
\newcommand{\@abstractkw}{%
        \@ifundefined{keywa}{}{\expandafter\MakeUppercase\keywa}%
        \@ifundefined{keywb}{}{, \keywb}%
        \@ifundefined{keywc}{}{, \keywc}%
        \@ifundefined{keywd}{}{, \keywd}%
        \@ifundefined{keywe}{}{, \keywe}%
        \@ifundefined{keywf}{}{, \keywf}%
        \@ifundefined{keywg}{}{, \keywg}%
        \@ifundefined{keywh}{}{, \keywh}%
        \@ifundefined{keywi}{}{, \keywi}%
        \@ifundefined{keywj}{}{, \keywj}%
}


%==============================================================================
% Dados do trabalhos
%==============================================================================
\renewcommand{\date}[2]{
        \gdef\@publmonth{#1}
        \gdef\@publyear{#2}
}
\date{\monthname}{\number\year}

\newcommand{\location}[2]{
        \gdef\@city{#1}
        \gdef\@state{#2}
}

\newcommand{\course}[1]{\gdef\@course{#1}}
\newcommand{\courseheader}[1]{\gdef\@courseheader{#1}}
\courseheader{\nulllogo[0.7]}

\newcommand{\docname}[1]{\gdef\@docname{#1}}
%==============================================================================
% Definio padro da folha de rosto.
% Os dados especficos do tipo de trabalho (dissertao, tese, etc.) so
% informados definindo-se o comando \titlepagespecificinfo. Veja os
% arquivos .def includos com a classe.
%==============================================================================
\renewcommand{\maketitle}{%
        \begin{titlepage}
                \thetitlepage
        \end{titlepage}%
        \clearpage
        \setcounter{page}{2}%
        \@ifundefined{@cipspecificinfo}{}{\@makecippage}
}

%==============================================================================
% Capa do trabalho
%==============================================================================
\newcommand{\thetitlepage}{%
    \noindent
    \begin{center}
				% Logo do curso/instituio
				\@courseheader
				
				% Espao entre logo e autores
				\vspace{1cm}
				
				% Autor(es) do trabalho
				\textbf{\MakeUppercase{\@authora}}\\
				\@ifundefined{@authorb}{}{\MakeUppercase{\textbf{\@authorb}}\\}%
				\@ifundefined{@authorc}{}{\MakeUppercase{\textbf{\@authorc}}\\}%
				\@ifundefined{@authord}{}{\MakeUppercase{\textbf{\@authord}}\\}%
				\vspace*{\fill}
				
				% Ttulo do trabalho
				{\textbf{\MakeUppercase{\@title}}\par}
				\vfill
				
				% Cidade e ano
				\centerline{\textbf{\@city}}
				\centerline{\textbf{\@publyear}}
    \end{center}
}

%==============================================================================
% Folha de Rosto
%==============================================================================
\newcommand{\@makecippage}{%
    \noindent
    \begin{center}
				\MakeUppercase{\@authora}\\
				\@ifundefined{@authorb}{}{\MakeUppercase{\@authorb}\\}%
				\@ifundefined{@authorc}{}{\MakeUppercase{\@authorc}\\}%
				\@ifundefined{@authord}{}{\MakeUppercase{\@authord}\\}%
				\vspace*{\fill}
				
				\MakeUppercase{\@title}\\
				\vspace*{\fill}
				
				\@docname\\
				\setrem\\
				\faculsetrem\\
				\@course
				\vspace*{\fill}
				
				\@ifundefined{@advisor}{}{\advisorname:\\\@advisor\\}
				\@ifundefined{@coadvisor}{}{\coadvisorname:\\\@coadvisor\\}
				\vspace*{\fill}
				
				% Cidade e ano
				\@city\\
				\@publyear
	  \end{center}
}

%==============================================================================
% Ajuste do sumrio (nada indentado) 
%==============================================================================
% s  usado no apndice, precisa ser revisado e removido se for o caso
\newlength{\ii@chapnumindent}\setlength{\ii@chapnumindent}{1.8em}

\newlength{\s@tocspace}\setlength{\s@tocspace}{1pt}

\renewcommand*{\l@chapter}[2]{
		\begingroup
				\setstretch{1}
				\parskip \s@tocspace
				\@dottedtocline{1}{0em}{4em}{\uppercase{\textbf{#1}}}{\hss #2}
		\endgroup
}

\renewcommand*{\l@section}[2]{
		\begingroup
				\setstretch{1}
				\parskip \s@tocspace
				\@dottedtocline{1}{0em}{4em}{\uppercase{#1}}{\hss #2}
		\endgroup
}

\renewcommand*{\l@subsection}[2]{
		\begingroup
				\setstretch{1}
				\parskip \s@tocspace
				\@dottedtocline{1}{0em}{4em}{\textbf{#1}}{\hss #2}
		\endgroup
}

\renewcommand*{\l@subsubsection}[2]{
		\begingroup
				\setstretch{1}
				\parskip \s@tocspace
				\@dottedtocline{1}{0em}{4em}{\textit{#1}}{\hss #2}
		\endgroup
}

\newif\if@aftertoc
\@aftertocfalse

\renewcommand{\tableofcontents}{%
        \chapter*{\contentsname}
        \@starttoc{toc}\@aftertoctrue%
}

%==============================================================================
% Definio das listas de abreviaturas e siglas e de smbolos
%==============================================================================
\newenvironment{listofabbrv}[1]{
        \chapter*{\listabbrvname}
        \begin{list}{\textbf{??}}{
                \settowidth{\labelwidth}{#1}
                \setlength{\labelsep}{1em}
                \setlength{\itemindent}{0mm}
                \setlength{\leftmargin}{\labelwidth}
                \addtolength{\leftmargin}{\labelsep}
                \setlength{\rightmargin}{0mm}
                \setlength{\itemsep}{.1\baselineskip}
                \renewcommand{\makelabel}[1]{\makebox[\labelwidth][l]{##1}}
        }
}{
        \end{list}
}
\newenvironment{listofsymbols}[1]{
        \chapter*{\listsymbolname}
        \begin{list}{\textbf{??}}{
                \settowidth{\labelwidth}{#1}
                \setlength{\labelsep}{1em}
                \setlength{\itemindent}{0mm}
                \setlength{\leftmargin}{\labelwidth}
                \addtolength{\leftmargin}{\labelsep}
                \setlength{\rightmargin}{0mm}
                \setlength{\itemsep}{.1\baselineskip}
                \renewcommand{\makelabel}[1]{\makebox[\labelwidth][l]{##1}}
        }
}{
        \end{list}
}

\newenvironment{singlespaced}%          environment name
{
    \setstretch{1}
}{}%                    end code

%==============================================================================
% Resumo (abstract) e Abstract (englishabstract)
%==============================================================================
\renewenvironment{abstract}{%
    \chapter*{\abstractname}
    \noindent
}{%
    \par
    \textbf{\keywordsname:} \@abstractkw.
}

\newenvironment{englishabstract}[2]{%
    \if@openright\cleardoublepage\else\clearpage\fi%
    \gdef\@englishkeywords{#2}%
    \begin{otherlanguage}{english}
    \chapter*{\abstractname}
    \noindent
}{
    \par
    \textbf{\keywordsname:} \@englishkeywords.
    \end{otherlanguage}
}


\newenvironment{introduction}{%
    \chapter*{\introductionname}
}{
    
}

%==============================================================================
% Formatao dos captulos.
% Os comandos \@chapter e \@schapter so redefinidos para que a
% numerao de pginas seja correta (deve aparecer somente a partir do
% primeiro captulo do texto, mas no nas pginas iniciais de
% captulos).
% Os comandos \@makechapterhead e \@makeschapterhead fazem a
% formatao dos ttulos propriamente ditos.
%==============================================================================
\newcommand{\ii@chapterfont}{\@setfontsize\normalsize{12pt}{20}}

\def\@chapapp{\chaptername}
\def\@chapter[#1]#2{%
        \refstepcounter{chapter}%
        \addcontentsline{toc}{chapter}{\@chapapp\thechapter: #1}%
        %\addtocontents{lof}{\protect\addvspace{10\p@}}%
        %\addtocontents{lot}{\protect\addvspace{10\p@}}%
        
        % este comando remove a paginao da primeira pgina
        \thispagestyle{empty}
        
        \@makechapterhead{#2}
        \@afterheading
        
        % agora volta a fazer a paginao normalmente
        \pagestyle{setrem}\let\ps@plain\ps@setrem%
        
}
\def\@makechapterhead#1{%
        \vspace*{3.2cm}
        \reset@font\noindent{
        		\ii@chapterfont\sffamily\textbf{
        				\MakeUppercase{\@chapapp}\thechapter:\hspace{1em}\MakeUppercase{#1}
        		}\par
        }
        %\addvspace{42pt}
}

\def\@schapter#1{%
		% só adiciona o capítulo se for após o sumário
        \if@aftertoc\addcontentsline{toc}{chapter}{#1}\fi%
        
        %\addtocontents{lof}{\protect\addvspace{10\p@}}%
        %\addtocontents{lot}{\protect\addvspace{10\p@}}%
        
        % este comando remove a paginao da primeira pgina
        \thispagestyle{empty}
        
        \@makeschapterhead{#1}
        \@afterheading
        
        % agora volta a fazer a paginao normalmente
        \pagestyle{setrem}\let\ps@plain\ps@setrem%
}
\def\@makeschapterhead#1{%
        \vspace*{4.2cm}
        \reset@font\centerline{\ii@chapterfont\sffamily\textbf{\MakeUppercase{#1}}}
        \addvspace{42pt}
}
\renewcommand{\appendix}[1][\appendixname]{%
        \setcounter{chapter}{0}%
        \renewcommand{\thechapter}{\Alph{chapter}}%
        \setcounter{tocdepth}{0}%
        \@captionlistingfalse%
        \gdef\@chapapp{\MakeUppercase{#1}\space}%
        \addtocontents{toc}{%
          \settowidth{\ii@chapnumindent}{{\sffamily\textbf{\@chapapp}}}
          \addtolength{\ii@chapnumindent}{1.8em}
        }%
}
\newcommand{\annex}{\appendix[\annexname]}

%==============================================================================
% Formatao das sees
%
% \@startsection {NAME}{LEVEL}{INDENT}{BEFORESKIP}{AFTERSKIP}{STYLE} 
%            optional * [ALTHEADING]{HEADING}
%    Generic command to start a section.  
%    NAME       : e.g., 'subsection'
%    LEVEL      : a number, denoting depth of section -- e.g., chapter=1,
%                 section = 2, etc.  A section number will be printed if
%                 and only if LEVEL < or = the value of the secnumdepth
%                 counter.
%    INDENT     : Indentation of heading from left margin
%    BEFORESKIP : Absolute value = skip to leave above the heading.  
%                 If negative, then paragraph indent of text following 
%                 heading is suppressed.
%    AFTERSKIP  : if positive, then skip to leave below heading,
%                       else - skip to leave to right of run-in heading.
%    STYLE      : commands to set style
%  If '*' missing, then increments the counter.  If it is present, then
%  there should be no [ALTHEADING] argument.  A sectioning command
%  is normally defined to \@startsection + its first six arguments.
%==============================================================================
\setcounter{secnumdepth}{4}
\def\@beforespace{4pt}
\def\@afterspace{4pt}

% Ttulo 2
\renewcommand{\section}{
		\@startsection{section}{1}{0pt}{\@beforespace}{\@afterspace}{\raggedright\reset@font\uppercase}
}

% Ttulo 3
\renewcommand{\subsection}{%
    \@startsection{subsection}{2}{0pt}{\@beforespace}{\@afterspace}{\raggedright\reset@font\bfseries}
}

% Ttulo 4
\renewcommand{\subsubsection}{%
    \@startsection{subsubsection}{3}{0pt}{\@beforespace}{\@afterspace}{\raggedright\reset@font\itshape}
}


\renewcommand{\paragraph}{%
    \@startsection{paragraph}{4}{0pt}{\@beforespace}{\@afterspace}{\raggedright\reset@font}
}
\renewcommand{\subparagraph}{%
    \@startsection{subparagraph}{5}{0pt}{1ex}{-1em}{\reset@font\bfseries}
}

%==============================================================================
% Redefinio do contedo das listas de figuras e tabelas
%==============================================================================
\newif\if@captionlisting\@captionlistingtrue
\long\def\@caption#1[#2]#3{%
  %\par
  \if@captionlisting%
    \addcontentsline{\csname ext@#1\endcsname}{#1}%
        {\protect\numberline{\csname fnum@#1\endcsname:}{\ignorespaces #2}}%
  \fi%
  \begingroup
  	% espaco entre linhas lista de figuras
  	%\setstretch{1.0}
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
    \normalsize
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}
  \endgroup%
}
\renewcommand*{\l@figure}{\@dottedtocline{1}{0em}{5.5em}}
\let\l@table\l@figure

\newcommand{\source}[1]{
		%\@setfontsize\normalsize{10pt}{20}
		\small%
        \sourcename: #1
}

\newcommand{\figurebox}[2]{
		\centerline{
			\setlength\fboxsep{0pt}
			\setlength\fboxrule{0.5pt}
			\fbox{
				\includegraphics[width=#1]{#2}
			}
		}
}

%\renewcommand{\fnum@figure}{\textbf{Fig.~\thefigure}}

%==============================================================================
% Redefinio do formato de citaes longas
%==============================================================================
%\renewenvironment{quote}{``}{''}
\renewcommand{\quote}[1]{
		``#1''
}

\newcommand{\itquote}[1]{
		``\textit{#1}''
}

\renewenvironment{quotation}{
	\begin{list}{}{
		\small%
    	\setstretch{1.0}
		\setlength{\leftmargin}{40mm}
	}
    	\item[]%
}{
	\end{list}
}

%\newcommand{\apudonline}[2]{
%	\citet{#1} \textit{apud} \citet{#2}
%}

\newcommand{\apudonline}[2]{
	\citeauthor{#1} (\citeyear{#1}, \textit{apud} \citeauthor{#2}, \citeyear{#2})
}

\newcommand{\apud}[2]{
	(\citeauthor*{#1}, \citeyear{#1} \textit{apud} \citeauthor*{#2}, \citeyear{#2})
}

%==============================================================================
% Ajuste do formato das citaes e referncias
%==============================================================================
%\setlength{\bibhang}{0pt}
%\let\cite\citep

%
% comandos DEPRECATED
% mantidos aqui somente para compatibilidade, nao constam mais do exemplo
% sugere-se remove-los a partir de julho/2003
% 07/dez/2002 - avila
%
\newcommand{\cip}{}
\newenvironment{dedicatoria}{%
        \clearpage%
        \mbox{}\vfill\begin{flushright}
}{
        \end{flushright}
}
\newenvironment{agradecimentos}{\chapter*{Agradecimentos}}{}
