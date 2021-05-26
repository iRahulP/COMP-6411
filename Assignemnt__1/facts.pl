%• class(Type): Type is defined as a class.
class('Human').
class('Bladerunner').
class('Machine').
class('Android').
class('Android2').

%• interface(Type): Type is defined as an interface.
interface('Behaviour').
interface('Behaviour2').

%• construction(Type, Signature): Type is instantiated by a constructor defines by
%Signature. In the case of a default constructor, use the keyword default.
construction('Human', default).
construction('Bladerunner', default).
construction('Bladerunner', 'String').
construction('Machine', default).
construction('Android', 'int').
construction('Android2', default).
construction('Android2', 'int').

%• extends(Subclass, SuperClass): Class Subclass directly extends class SuperClass.
extends('Bladerunner', 'Human').
extends('Android', 'Machine').
extends('Android2', 'Android').

%• implements(Type, Interface): Type directly implements Interface.
implements('Human', 'Behaviour').
implements('Machine', 'Behaviour').
implements('Android2', 'Behaviour2').

%• defines(Type, FeatureName, Kind, AccessType): Class Type defines feature FeatureName
%with access control AccessType, where Kind can be either one of method, or attribute.
defines('Behaviour', 'act()', method, public).
defines('Behaviour', 'reason()', method, public).

defines('Human', 'type', attribute, public).
defines('Human', 'empathy', attribute, public).
defines('Human', 'act()', method, public).
defines('Human', 'reason()', method, public).
defines('Human', 'hasEmpathy()', method, public).

defines('Bladerunner', 'type', attribute, public).
defines('Bladerunner', 'rank', attribute, public).
defines('Bladerunner', 'reason()', method, public).

defines('Machine', 'type', attribute, public).

defines('Android', 'version', attribute, public).
defines('Android', 'whatIHave()', method, public).
defines('Android', 'whatINeed()', method, public).
defines('Android', 'act()', method, public).
defines('Android', 'reason()', method, public).

defines('Behaviour2', 'empathy', attribute, public).
defines('Behaviour2', 'memories', attribute, public).
defines('Behaviour2', 'hasEmpathy()', method, public).
defines('Behaviour2', 'hasMemories()', method, public).

defines('Android2', 'whatIHave()', method, public).
defines('Android2', 'hasEmpathy()', method, public).
defines('Android2', 'hasMemories()', method, public).