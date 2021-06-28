#include <stdio.h>
#include <stdlib.h>

typedef enum
{
    ATOM,
    LIST
} eltype;

typedef char atom;
struct _listnode;

typedef struct
{
    eltype type;
    union
    {
        atom a;
        struct _listnode *l;
    };
} element;

typedef struct _listnode
{
    element el;
    struct _listnode *next;
} * list;

const element NIL = {.type = LIST, .l = NULL};

// Question 1.
element aasel(atom a)
{
    element ne = {.a = a, .type = ATOM};
    return ne;
}

// Question 2
element lasel(list l)
{
    element ne = {
        .type = LIST,
        .l = l};

    return ne;
}

// Question 3
list cons(element e, list l)
{
    list nl = malloc(sizeof(list));
    nl->el = e;

    if (l != NULL)
        nl->next = l;

    return nl;
}

// Question 4
list append(list l1, list l2)
{
    list l_append = malloc(sizeof(list));
    list curr = l_append; // Points to last node in the new list.

    while (l1 != NULL)
    {
        curr->el = l1->el;
        curr->next = malloc(sizeof(list));

        l1 = l1->next;
        curr = curr->next;
    }

    while (l2 != NULL)
    {
        curr->el = l2->el;
        if (l2->next != NULL)
            curr->next = malloc(sizeof(list));

        l2 = l2->next;
        curr = curr->next;
    }

    return l_append;
}

// Question 5
element car(element e)
{
    if (e.type == ATOM)
    {
        return NIL;
    }
    else
    {
        return e.l->el;
    }
}

// Question 6
list cdr(element e)
{
    if (e.l != NULL)
    {
        list li = e.l->next;
        return li;
    }
    else
    {
        return NULL;
    }
}

// Question 7
list cddr(element e)
{
    list li = e.l->next;

    if (li == NULL || li->next == NULL)
    {
        return NULL;
    }

    return li->next;
}

// Question 8
void print(element e)
{
    if (e.type == ATOM)
    {
        printf(" %c ", e.a);
    }
    else if (e.l == NULL)
    {
        printf("NIL");
    }
    else
    {
        printf("(");
        list curr = e.l;
        while (curr != NULL)
        {
            print(curr->el);
            curr = curr->next;
        }
        printf(")");
    }
}

//Question 9
void freel(list l)
{
    if (l->el.type == LIST)
    {
        // printf("Calling free \n");
        freel(l->el.l);
    }

    if (l->next != NULL)
    {
        // printf("Calling free \n");
        freel(l->next);
    }

    free(l->next);
}

int main()
{
    element ea = aasel('a');
    element eb = aasel('b');
    element ec = aasel('c');
    element ed = aasel('d');
    element ee = aasel('e');

    list lb = cons(eb, cons(ec, NULL));
    element nested = lasel(lb);
    element theList = lasel(cons(ea, cons(nested, cons(ed, cons(ee, NULL)))));

    print(theList);
    printf("\n");
    print(car(theList));
    printf("\n");
    print(lasel(cdr(theList)));
    printf("\n");
    print(car(car(theList)));
    printf("\n");

    freel(theList.l);

    return 0;
}