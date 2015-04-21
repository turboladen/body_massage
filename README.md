BodyMassage
===========

Description
-----------

BodyMassage is somewhat of a hybrid of an object-oriented language and a
functional one. ...and is really just a toy/experiment.

### Philosophy

Objects with methods/functions can lead to easy-to-read code, yet problems can
come when programming for concurrency where > 1 process tries to write to the
object. As such, BodyMassage does not allow altering the state of an object's
attributes once they've been set. This leaves objects and their accessors
feeling a bit functional, yet still looking mostly object-like.

### Initial Goals

* Objects are read-many/write-once.
* Very few keywords; most objects are created by functions.
* Return and parameter types must be declared (multiple types and wildcards are
  allowed).
* Emphasis on simplifying concurrency (easy actor/reactor patterns).
* Statement termination is required.
* No whitespace restrictions.
* Built-in REPL.
* Metaprogramming.
* All objects inherit from `Null` (making something from nothing mmmouahaha).
* Variables of a declared type can also be assigned a object whose type is a
  parent to the declared type.

Basic Types
-----------

### Scalars

* `Boolean`. Simply `true` or `false`.

  ```
  [Boolean] hungry = true;
  ```

* `String`

  ```
  [String] name = 'Steve';
  ```

* `Number`. Integers, Floats, Doubles, etc. Nothing complex or rational. Yet.

  ```
  [Number] age = 30.1;
  ```

* `Null`. The absence of value. If two objects are set to `null`, they are set
  to be equal two separate objects whose type is `Null`.

  ```
  [Number] tail_count;      # evaluates to null.
  ```

### Complex

As with all data types, once these objects have been created, the cannot be
updated.

* `Map`. An array of key/value pairs (aka an associative array, dictionary,
  hash), where keys and values can be any other type. Notice the syntax for
  declaring allowable data types for keys and values: the comma-separated list
  after the `:` indicates allowable value types.

  ```
  [Map<String: String,Number>] config = <"username" : "turboladen", "password" : 42>;
  [Map<String: String,Number>] config = <username: "turboladen", password: 42>;
  ```

* `Table`?

* `Tuple`. A finite list of objects of any type. Notice the `*` declaration here:
  The wild-card denotes that the tuple can take values of any type.

  ```
  [Map<String: Number>] favorites = <ice_cream: 17, candy: 42>;
  [Tuple{*}] tuppy = {1, 'forty-two', false, favorites};
  ```

* `Object`

  ```
  Ricky = Object.define ->
    [String] attribute first_name = 'Ricky';
    [String] attribute last_name;
  end_Object

  [Ricky] schroeder = Ricky.new(last_name: 'Schroeder');
  [Ricky] gervais = Ricky.new(last_name: 'Gervais');
  ```

