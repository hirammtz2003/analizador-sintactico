%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
int yylex(void);
%}

%token IDENTIFICADOR ASIGNACION ENTERO FLOTANTE OPERADOR COMILLA_SOLA CADENA_LITERAL BOOLEANO PUNTO_Y_COMA PARENTESIS_APERTURA PARENTESIS_CIERRE
%start instrucciones

%left '+' '-'
%left '*' '/' '%'
%right ASIGNACION

%%

instrucciones: instrucciones A | A;

A: IDENTIFICADOR ASIGNACION VALOR PUNTO_Y_COMA { printf("Asignacion valida\n"); }
 ;

VALOR: BOOLEANO
     | CADENA_LITERAL
     | EXPRESION_NUMERICA
     | COMILLA_SOLA
     ;

EXPRESION_NUMERICA: EXPRESION_NUMERICA '+' TERMINO
                  | EXPRESION_NUMERICA '-' TERMINO
                  | TERMINO
                  ;

TERMINO: TERMINO '*' FACTOR
       | TERMINO '/' FACTOR
       | TERMINO '%' FACTOR
       | FACTOR
       ;

FACTOR: ENTERO
      | FLOTANTE
      | IDENTIFICADOR
      | PARENTESIS_APERTURA EXPRESION_NUMERICA PARENTESIS_CIERRE
      ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    return yyparse();
}

