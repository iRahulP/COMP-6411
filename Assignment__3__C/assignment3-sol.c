#include <stdio.h>
#include <stdlib.h>

typedef enum { ATOM, LIST } eltype;
typedef char atom;
struct _listnode;
typedef struct {
eltype type;
union {
atom a;
struct _listnode* l;
};
} element;
typedef struct _listnode {
element el;
struct _listnode* next;
} * list;
const element NIL = { .type=LIST, .l=NULL };

element aasel(atom a) {
    element e = { .type = ATOM, .a = a };
    return e;
}

element lasel(list l) {
    element e = { .type = LIST, .l = l };
    return e;
    
}

list new_node(element e) {
    list n = malloc(sizeof(struct _listnode));
    if(!n) { printf("malloc error"); exit(-1); }
    n->el = e;
    n->next = NULL;
    return n;
}

list cons(element e, list l) {
    list n = new_node(e);
    n->next = l;
    return n;
}

list shallow_copy(list l) {
    if(!l) return NULL;
    list r = new_node(l->el);
    r->next = shallow_copy(l->next);
    return r;
}

list append(list l1, list l2) {
    list l;
    l1 = shallow_copy(l1);
    l2 = shallow_copy(l2);
    if(!l1) return l2;
    if(!l2) return l1;
    l = l1;
    for(; l->next; l = l->next)
        ;
    l->next = l2;
    return l1;
}

element car(element e) {
    return e.type != LIST? NIL: (e.l)->el;
}

list cdr(element e) {
    return e.type != LIST? NULL: (e.l)->next;
}

list cddr(element e) {
    list r = cdr(e);
    return r? r->next: NULL;
}

void lfree(list l) {
    if(!l) return;
    if(l->next) lfree(l->next);
    if(l->el.type == LIST) lfree(l->el.l);
    free(l);
}

void print(element e) {
    list l;
    switch(e.type) {
      case ATOM: 
        printf(" %c ", e.a);
        break;
      case LIST: 
        if(!e.l) { printf("NIL"); break; }
        printf("(");
        for(l = e.l; l; l = l->next)
          print(l->el);
        printf(")");
        break;
    }
}

int main()
{
    list l = cons(aasel('e'), NULL);
    l = cons(aasel('d'), l);
    l = cons(lasel(cons(aasel('b'), cons(aasel('c'), NULL))), l);
    l = cons(aasel('a'), l);
    element e = lasel(l);
    print(e);
    printf("\n");
    print(car(e));
    printf("\n");
    print(lasel(cdr(e)));
    printf("\n");
    print(car(car(e)));
    printf("\n");
    lfree(l);
    return 0;
}
