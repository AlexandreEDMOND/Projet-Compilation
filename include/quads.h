
// Définit un quad
typedef struct Quad {
    char op; // = (pour déclaration ou affectation) ou p (pour print)
    char * operand1; 
    char * operand2;
} Quad;

// Liste de quads
typedef struct Quad_list {
    Quad **data;
    int size;
    int capacity;
} Quad_list;


Quad_list* init_quad_list();

Quad_list *create_list(Quad *quad);

void gencode(char op, char* operande1, char* operande2);

void add_quad(Quad_list *quad_list, Quad *quad);

void free_quad_list(Quad_list *quad_list);

void print_quad_list(Quad_list *quad_list);

void print_quad(Quad * quad);

void print_list_quad_MIPS(Quad_list* quad_list);

void print_quad_MIPS(Quad* quad);