%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
extern FILE *yyin; // Declara yyin para poder cambiar la entrada de yyparse
%}

%token IDENTIFICADOR ASIGNACION ENTERO FLOTANTE OPERADOR CADENA_LITERAL BOOLEANO PUNTO_Y_COMA PARENTESIS_APERTURA PARENTESIS_CIERRE
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
    exit(1); // Finaliza la ejecución en caso de error
}

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror(argv[1]);
            return 1;
        }
    }
    return yyparse();
}
