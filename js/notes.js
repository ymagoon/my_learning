/*
The following built-in types are available:
  string
  number
  boolean
  null
  undefined
  object
  symbol
*/

// You can use typeof operator to determine the type of a variable

let a;
typeof a;       // undefined

a = "hello world";
typeof a;       // "string"

a = 42;
typeof a;       // "number"

a = true;
typeof a;       // "boolean"

a = null;
typeof a;       // "object" -- weird, bug

a = undefined;
typeof a;       // "undefined"

a = { b: "c" };
typeof a;       // "object"







//converting variables to a different type is called coercion
let a = "42"
let b = Number(a);

console.log(a);   // "42"
console.log(b);   //  42

// But a controversial topic is what happens when you try to compare two values that are not already of
// the same type, which would require implicit coercion.

// JavaScript will sometimes kick in and implicitly coerce values to the matching types.
"42" == 42;    // true

