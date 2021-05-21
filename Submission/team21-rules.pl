:- consult(facts).


is_type(Type):-
      ( class(Type) ; interface(Type) ).


% 1. empty_class/1: Succeeds when a type defines no features.
empty_class(Empty_Type) :-
    is_type(Empty_Type),
    \+ defines(Empty_Type, _, _, _).


% 2. lazy_class/1: Succeeds when a type defines only one method.
lazy_class(Lazy_Type) :-
    is_type(Lazy_Type),
    findall(Lazy_Type , defines(Lazy_Type, _, method, _), List),
    length(List, Length),
    Length == 1.


% 3. data_type/1: Succeeds when a type defines attributes, but does not define any methods.
data_type(Type) :-
    is_type(Type),
    defines(Type, _, attribute, _),
    \+ defines(Type, _, method, _).


% 4. child/1 Succeeds by finding a set of direct subtype-supertype pairs.
child(Set):-
    findall([Sub_Type, Super_Type], extends(Sub_Type, Super_Type); implements(Sub_Type, Super_Type), List),
    list_to_set(List, Set).


% 5. child/2: Succeeds when it finds a subtype relationship
child(Child_Type, Parent_Type) :-
    is_type(Child_Type),
    is_type(Parent_Type),
    extends(Child_Type, Parent_Type) ; implements(Child_Type, Parent_Type).


% 6. ancestor/2: Succeeds when it finds all ancestors of a given type
ancestor(Ancestor, Type) :-
    child(Type, Ancestor).

ancestor(Ancestor, Type) :-
    child(Type, Parent_Type),
    ancestor(Ancestor, Parent_Type).


% 7. state_of/2: Succeeds by obtaining the state of a given type.
state_of(Type, State):-
    findall(Feature, (defines(Type, Feature, attribute, _) ; ancestor(Ancestor, Type), defines(Ancestor, Feature, attribute, _)), State).


% 8. interface_of/2 Succeeds when List contains a list of all messages (method calls) that make up the interface of class Type.
interface_of(Type, Interface) :-
    findall(Feature, (  defines(Type, Feature, method, _ )  ; ( ancestor(Ancestor, Type), defines(Ancestor, Feature, method, _ ) )  ), List),
    list_to_set(List, Interface).


% 9. siblings/1: Succeeds by obtaining a pair of sibling types.
siblings(Siblings_List) :-
    findall( [Sibling_A, Sibling_B], ( child(Sibling_A, Parent_Type), child(Sibling_B, Parent_Type), Sibling_A \= Sibling_B ), Siblings_List).


% 10. instantiated_polymorphically /1: Succeeds when a type is instantiated using poly-morphism.
instantiated_polymorphically(Type) :-
    class(Type),
    construction(Type, Signature),
    Signature \= default.

% 11. root/1: Succeeds by finding a type with no ancestors. Uses is type/1 which succeeds when a type is either a class or an interface.
root(Root) :-
    is_type(Root),
    \+ ancestor(_, Root).


% 12. provides interface/2: Succeeds by obtaining a list of all classes that implement a given interface.
provides_interface(Interface, Class_List) :-
    findall(Class, (  class(Class), ( implements(Class, Interface) ; ( ancestor(Interface, Type), ( implements(Class, Type) ; extends(Class, Type) )  )   )   ), Class_List).




