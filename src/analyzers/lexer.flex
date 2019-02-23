package usac.compiladores;

import java_cup.runtime.*;

%%

%class lexer
%public
%cup
%column
%line
%caseless
%state MLCOMMENT
%state SLCOMMENT
%state TAG_BODY

%{
    StringBuilder textoMultiple = new StringBuilder();

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

letra=[a-zA-Z]
digito=[0-9]
S = (\u0020)  //whitespace

id = [:jletter:]( "_" | "-" | [:jletterdigit:])*
path = ("/"( "_" | "." | [:jletterdigit:])*)+
texto_multiple = [^\r\n\<\>\(\)]*
funcion = "{" {id} "(" {texto_multiple} ")" "}"

%%

<YYINITIAL> "<"
                        {
                            yybegin(YYINITIAL);
                            String abreTag = new String(yytext());
                            System.out.println("ABRE TAG --"+yytext()); 
                            return symbol(sym.ABRE_TAG, abreTag);
                        }
<YYINITIAL> ">"         {
                            yybegin(TAG_BODY);
                            String cierraTag = new String(yytext());
                            System.out.println("CIERRA TAG --" + cierraTag); 
                            return symbol(sym.CIERRA_TAG, cierraTag);
                        }
<YYINITIAL> "="         { 
                            String igual = new String(yytext());
                            System.out.println("IGUAL --" + igual); 
                            return symbol(sym.IGUAL, igual);
                        }
<YYINITIAL> "/"         { 
                            String diagonal = new String(yytext());
                            System.out.println("DIAGONAL --" + diagonal); 
                            return symbol(sym.DIAGONAL, diagonal);
                        }

<YYINITIAL> "{"         {
                            String a = new String(yytext());
                            System.out.println("DIAGONAL --" + a);
                            //return symbol(sym.DIAGONAL, a);
                        }
<YYINITIAL> \"{id}\"    { 
                            String a = new String(yytext());
                            System.out.println("VALOR ATRIBUTO TEXTO --" + a);
                            return symbol(sym.TEXTO, a);
                        }

<YYINITIAL> {funcion}  {
                            String a = new String(yytext());
                            System.out.println("FUNCION --" + a);
                            return symbol(sym.FUNCION, a);
                        }

<YYINITIAL>{digito}({digito})*
                    {
                        String digito = new String(yytext());
                        System.out.println("VALOR ATRIBUTO ENTERO -- " + digito);
                        return symbol(sym.ENTERO, digito);
                    }

<YYINITIAL> {id}        {
                            String a = new String(yytext());
                            System.out.println("NOMBRE --" + a);
                            return symbol(sym.NOMBRE, a);
                        }

<TAG_BODY> {
    "<"                 {
                            yybegin(YYINITIAL);
                            System.out.println("ABRE TAG (tag body) --"+yytext());

                            return symbol(sym.ABRE_TAG, yytext());
                        }

    {texto_multiple}*
                            {
                                //yybegin(YYINITIAL);
                                textoMultiple.append(yytext());
                                System.out.println("TEXTO MULTIPLE (tag body) --" + textoMultiple);
                            }
}

<YYINITIAL> "/*"			        {   yybegin(MLCOMMENT); }
<MLCOMMENT> .                       {   yybegin(MLCOMMENT);}
<MLCOMMENT> "*/"				    {   yybegin(YYINITIAL);}


<YYINITIAL> "//" ({digito}|{letra}|.)*\r\n	    { yybegin(SLCOMMENT);
                                                    printMessage("SL Comment -- "+yytext());}

<SLCOMMENT> .                                   { }
<SLCOMMENT> (\r|\n|\r\n)                        { yybegin(YYINITIAL);
                                                    printMessage("SL Comment -- "+yytext());}


<YYINITIAL> [ ]+                    { printMessage("whitespace"); }

<YYINITIAL, TAG_BODY> \r\n          {
                                        printMessage("return y salto de linea");
                                    }

<YYINITIAL> \t                              { printMessage("tabulación"); }

<YYINITIAL, TAG_BODY> (\r|\n|\r\n)[\n\r\t]+	    { printMessage("return o salto de línea, o ambos, o return salto y tabulación"); }

<YYINITIAL, TAG_BODY> \n				{ printMessage("salto de línea"); }



<YYINITIAL, TAG_BODY>.                       { System.out.println( "Caracter no Esperado, ERROR LEXICO " + yytext() ); }