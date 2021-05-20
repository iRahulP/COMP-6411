:- consult(facts).


is_type(X):-
      (class(X);interface(X)).


% 1. empty_class/1: Succeeds when a type defines no features.
empty_class(X) :-
    class(X),
    \+ defines(X,_,_,_).


% 2. lazy_class/1: Succeeds when a type defines only one method.
lazy_class(X) :-
    class(X),
    findall(X,defines(X,_,method,_),L),
    length(L, S),
    S==1.


% 3. data_type/1: Succeeds when a type defines attributes, but does not define any methods.
data_type(X) :-
    class(X),
    defines(X,_,attribute,_),
    \+ defines(X,_,method,_).


% 4. child/1 Succeeds by finding a set of direct subtype-supertype pairs.
child(S):-
      findall([X,Y], extends(X,Y), List1),
      findall([X,Y], implements(X,Y), List2),
      append(List1,List2, List),
      list_to_set(List, S).


% 5. child/2: Succeeds when it finds a subtype relationship
child(X,Y) :-
    is_type(X),
    is_type(Y),
    extends(X,Y);
    implements(X,Y).


% 6. ancestor/2: Succeeds when it finds all ancestors of a given type
ancestor(X,Y) :-
    child(Y,X).

ancestor(X,Y) :-
    child(Y,Z),
    ancestor(X,Z).


% 7. state_of/2: Succeeds by obtaining the state of a given type.
state_of(C, State):-
    findall(Feature, (defines(C, Feature, attribute, _);ancestor(A, C), defines(A, Feature, attribute, _)), State).


% 8. interface_of/2 Succeeds when List contains a list of all messages (method calls) that make up the interface of class Type.
interface_of(X,S) :-
    extends(X,Y),
    findall(A, defines(X, A, method, _ ), List1),
    findall(B, defines(Y, B, method, _), List2),
    append(List1,List2,List),
    list_to_set(List,S).


% 9. siblings/1: Succeeds by obtaining a pair of sibling types.
siblings(X) :-
    findall([Y,Z],(child(Y,P),child(Z,P),Y\=Z),X).


% 10. instantiated_polymorphically /1: Succeeds when a type is instantiated using poly-morphism.
instantiated_polymorphically(Type) :-
    class(Type),
    construction(Type, X),
    X \= default.

% 11. root/1: Succeeds by finding a type with no ancestors. Uses is type/1 which succeeds when a type is either a class or an interface.
root(R) :-
    is_type(R),
    \+ extends(R,_),
    \+ implements(R,_).


% 12. provides interface/2: Succeeds by obtaining a list of all classes that implement a given interface. (NOT FINISHED YET)
temp_interface(L,S) :-
    write(L),nl,
    length(L,N),
    (\+ (N = 0)),
    write(N),nl,
    [H|T]=L,
    write(H),nl,
    findall(V, extends(V,H), List),
    write(List),nl,
    write(S),nl,
    append(L,List,S),
    write(S),nl,
    temp_interface(T,S),
    %temp_interface(List,S),
    write(S).

provides_interface(X,L) :-
    interface(X),
    findall(A,implements(A,X),L),
    length(L,N),
    (\+ (N = 0)),
    temp_interface(L,S).




