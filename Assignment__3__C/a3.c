#include <stdio.h>

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
        struct _listnode* l;
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
    //printf("In Cons ");
    list li = malloc(sizeof(list));

    li->el = e;
    li->next = l;

    return li;
}


// Question 4
list append(list l1, list l2)
{
    element e;
    list l_append = NULL;
    l_append = malloc(sizeof(list));

    list res = l_append;

    while(l1 != NULL )
    {
        l_append->el = l1->el;
        l1 = l1->next;
        list temp = malloc(sizeof(list));
        l_append->next = temp;
        l_append = l_append->next;
    }

    while(l2 != NULL )
    {
        l_append->el = l2->el;
        l2 = l2->next;
        list temp = malloc(sizeof(list));
        l_append->next = temp;
        l_append = l_append->next;
    }

    return res;


    // res = l1;
    // list temp = res;
    // while(temp->next != NULL)
    // {
    //     temp = temp->next;
    // }
    // temp->next = l2;

    // return res;
}


// Question 5
element car(element e)
{
    if(e.type == ATOM)
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
	if(e.type == ATOM)
    {
        return NIL;
    }
    //fetches el of the e as list
    e = e.l->el;
    return e.l;
}

// Question 7
list cddr(element e)
{
	if(e.type == ATOM)
    {
        return NIL;
    }
    
    list temp = malloc(sizeof(list));
    temp = cdr(e);
    return temp.next;
}


// Question 8
void print(element e)
{
    if (e.type == ATOM)
    {
        printf(" %c \n", e.a);
    }
    else if (e.l == NULL)
    {
        printf("NIL");
    }
    else
    {
        //TODO: Recursively print list;
    }
}



int main()
{
    printf("\n-------- Start ---------- \n");
    element e1 = {.a = 'A', .type = ATOM};
    element e2 = aasel('C');

    print(e1);
    print(e2);

    printf("\n-------- End ---------- \n");
    return 0;
}
