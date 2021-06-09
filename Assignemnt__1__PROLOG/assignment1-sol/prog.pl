%% Consult file that contains the facts.
:- consult(facts).

%%==============================================================================
%% Section 4.2
%%==============================================================================

% What classes, if any, are present in the program?
% 
% ?- class(C).
% C = 'Human' ;
% C = 'Bladerunner' ;
% C = 'Machine' ;
% C = 'Android' ;
% C = 'Android2' ;
% false.
% 
% 
% 
% What methods, if any, does class 'Human' define?
% 
% ?- defines('Human', Signature, method, _).
% Signature = 'act()' ;
% Signature = 'reason()' ;
% Signature = 'hasEmpathy()' ;
% false.
% 
% 
% Does class 'Android' define an attribute named 'version'?
% 
% ?- defines('Android', version, attribute, _).
% 
% 
% Does class 'Machine' define a method named 'hasMemories()'?
% 
% ?- defines('Machine', 'hasMemories()', method, _).
% false.
% 
% Which class, if any, extends class 'Human'?
% 
% ?- extends(T, 'Human').
% T = 'Bladerunner' ;
% false.
% 
% Which type, if any, implements interface 'Behavior2'?
% ?- implements('Bladerunner', 'Behavior2').
% false.



%%==============================================================================
%% Section 4.3
%%==============================================================================

%% empty_class/1: Succeeds when it finds a class Type with no features
%%
empty_class(Type) :- class(Type), not(defines(Type, _, _, _)).



%% lazy_class/1: Succeeds when Type defines only one method.
%%
lazy_class(Type) :-
  class(Type),
  findall(FeatureName,
          (class(Type), defines(Type, FeatureName, method, _)),
          List),
  length(List, Length),
  Length =:= 1.



%% data_type/1: Succeeds when Type defines attributes but it does not define methods.
%%
data_type(Type) :- defines(Type, _, attribute, _),
                     not(defines(Type, _, method, _)).



%% child/1: Succeeds by finding a set of direct subtype-supertype pairs.
%%
child(Set) :-
   findall([Child, Parent],
            (extends(Child, Parent); implements(Child, Parent)),
            L),
            list_to_set(L, Set).


%% child/2: Succeeds when it finds a subtype relationship
%%
child(Child, Parent) :- extends(Child, Parent); implements(Child, Parent).


%% ancestor/2: Succeeds when it finds all ancestors of a given type
%%
ancestor(A, Type) :-  child(Type, A).
ancestor(A, Type) :-  child(Type, SomeType), ancestor(A, SomeType).



%%  state_of/2: Succeeds by obtaining the state of a given type
%%
state_of(Type, List) :-
  findall(Attribute,
          (
            class(Type), defines(Type, Attribute, attribute, _);
            ancestor(Ancestor, Type), defines(Ancestor, Attribute, attribute, _)
          ),
          List).



%% interface_of/2: Succeeds by obtaining the interface of Type
%%
interface_of(Type, Set) :-
 findall(Method,
          (
             class(Type),
              (
                 defines(Type, Method, method, public);
                 defines(Type, Method, method, protected)
              ) ;
             ancestor(Ancestor, Type),
              (
                 defines(Ancestor, Method, method, public);
                 defines(Ancestor, Method, method, protected)
              )
          ),
          List),
          list_to_set(List, Set).
          
          

%% siblings/1: Succeeds by obtaining a pair of sibling types
%%
siblings(List) :- findall([A, B],
                          (child(A, Parent), child(B, Parent), A \== B),
                           List).

%% instantiated/1:  Succeeds when a type is instantiated using polymorphism.
%%
instantiated_polymorphically(Type) :- class(Type),
                      construction(Type, Signature),
                      Signature \== 'default'.

%%  root/1: Succeeds by finding the root of the inheritance tree.
%%
is_type(Type) :- class(Type); interface(Type).
root(Type) :- is_type(Type), \+ ancestor(_, Type).


%% provides_interface/2: Succeeds by obtaining a list containing all classes that support Interface.
%%
provides_interface(Interface, List) :-
                          findall(Type,
                                 (class(Type),
                                  implements(Type, Interface);
                                  (ancestor(A, Type), implements(A, Interface))
                                  ),
                                  List).



%%/eof.
