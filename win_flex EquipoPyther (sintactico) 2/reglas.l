%{
#include <stdio.h>
#include "parser.tab.h"  // Asegúrate de incluir el encabezado generado por Bison
%}

%%
True                return BOOLEANO;
False               return BOOLEANO;
[a-zA-Z][a-zA-Z0-9_]* return IDENTIFICADOR;
\"[^\"]*\"          return CADENA_LITERAL;
[0-9]+             return ENTERO;
[0-9]*\.[0-9]+     return FLOTANTE;
;                  return PUNTO_Y_COMA;
\(                 return PARENTESIS_APERTURA;
\)                 return PARENTESIS_CIERRE;
=                  return ASIGNACION;
[\+\-\*\/%]        return yytext[0];
[ \t\n]+           /* ignorar espacios en blanco */;
.                  return yytext[0];
%%

int yywrap() {
    return 1;
}
