package analyzers;

import java_cup.runtime.*;

%%

%class lexer
%public
%cup
%column
%line
%caseless
%state MLCOMMENT, CUERPO_TEXTO

%{
    private void printMessage(String s) {
        System.out.println(s);
    }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

%eofval{

    //MostrarMensaje("Fin de Archivo");
    return new Symbol(sym.EOF);

%eofval}


//letra=[a-zA-Z]
digito=[0-9]
entero = {digito}({digito})*
todo = [^\r\n];
texto_doble_comilla = [^\r\n\"];


/* white space , tab (/t) , carriage return (/r) , newline (/n) */
S = (\u0020)+
//S = (\u0020 | \u0009 | \u000D | \u000A)+

//texto =  ("_" | "-"  | "." | {letra} | {digito})+
texto =  [^\r\n\"<>=\{\}\(\)]+;
id    = [:jletter:]( "_" | "-" | [:jletter:])+
path = "/"( "." | [:jletterdigit:])+
nombre = [:jletter:]([:jletterdigit:])+
accion = "{" {nombre} "(" {todo} ")}"
atributo_texto = \"{texto_doble_comilla}+\"


/* comments */
CommentStart = "/*"
CommentEnd = "*/"


%%

<YYINITIAL> {

 "</"{nombre}">"                {
                                    String e = new String(yytext());
                                    printMessage("TAG_FINAL -- " + e);
                                    return symbol(sym.TAG_FINAL, e);
                                }

 {entero}                       {
                                    String e = new String(yytext());
                                    printMessage("ENTERO -- " + e);
                                    return symbol(sym.ENTERO, e);
                                }

 \"{texto}\"         {
                                    String texto = new String(yytext());
                                    printMessage("VALOR_TEXTO -- " + texto);
                                    return symbol(sym.VALOR_TEXTO, texto);
                                }    

  {id}                          {
                                    String a = new String(yytext());
                                    printMessage("NOMBRE -- " + a);
                                    return symbol(sym.NOMBRE, a);
                                }   

      

  "<"                           {
                                    String a = new String(yytext());
                                    System.out.println("ABRE_TAG -- " + a); 
                                    return symbol(sym.ABRE_TAG, a);
                                }
  
  ">"                           {
                                    yybegin(CUERPO_TEXTO);
                                    String a = new String(yytext());
                                    System.out.println("CIERRA_TAG -- " + a); 
                                    return symbol(sym.CIERRA_TAG, a);
                                }

  \"                            {
                                    String a = new String(yytext());
                                    System.out.println("COMILLA -- " + a); 
                                    return symbol(sym.COMILLA, a);
                                }

  "="                           {
                                    String a = new String(yytext());
                                    System.out.println("IGUAL -- " + a); 
                                    return symbol(sym.IGUAL, a);
                                }

  "/"                           {
                                    String a = new String(yytext());
                                    System.out.println("DIAGONAL -- " + a); 
                                    return symbol(sym.DIAGONAL, a);
                                }

  "{"                           {
                                    String a = new String(yytext());
                                    System.out.println("ALLAVE -- " + a); 
                                    return symbol(sym.ALLAVE, a);
                                }

  "}"                           {
                                    String a = new String(yytext());
                                    System.out.println("CLLAVE -- " + a); 
                                    return symbol(sym.CLLAVE, a);
                                }

  "("                           {
                                    String a = new String(yytext());
                                    System.out.println("APAR -- " + a); 
                                    return symbol(sym.APAR, a);
                                }

  ")"                           {
                                    String a = new String(yytext());
                                    System.out.println("CPAR -- " + a); 
                                    return symbol(sym.CPAR, a);
                                } 
 
  {CommentStart}                {
                                     yybegin(MLCOMMENT);
                                }

}

<CUERPO_TEXTO> {

    {texto}                     {
                                    String texto = new String(yytext());
                                    printMessage("TEXTO -- " + texto);
                                    return symbol(sym.TEXTO, texto);
                                }

    "<"                         {
                                    yybegin(YYINITIAL);
                                    String a = new String(yytext());
                                    System.out.println("ABRE_TAG -- " + a); 
                                    return symbol(sym.ABRE_TAG, a);
                                }

}

<YYINITIAL> \r\n                {
                                    printMessage("return y salto de linea");
				}

<YYINITIAL> \t                              { printMessage("tabulación"); }

<YYINITIAL> (\r|\n|\r\n)[\n\r\t]+	{ printMessage("return o salto de línea, o ambos, o return salto y tabulación"); }

<YYINITIAL> \n				{ printMessage("salto de línea"); }

//<MLCOMMENT> .                           	{   yybegin(MLCOMMENT);}
<MLCOMMENT> {CommentEnd}			{   yybegin(YYINITIAL);}

