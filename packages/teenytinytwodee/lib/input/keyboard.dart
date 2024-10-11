enum KeyboardKey {
  escape,
  space,
  up,
  down,
  left,
  right,
  enter,
  delete,
  shift,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  zero,
  a,
  b,
  c,
  d,
  e,
  f,
  g,
  h,
  i,
  j,
  k,
  l,
  m,
  n,
  o,
  p,
  q,
  r,
  s,
  t,
  u,
  v,
  w,
  x,
  y,
  z,
}

KeyboardKey getKeyFromCode(int code) {
  switch (code) {
    case 27:
      return KeyboardKey.escape;
    case 32:
      return KeyboardKey.space;
    case 38:
      return KeyboardKey.up;
    case 40:
      return KeyboardKey.down;
    case 37:
      return KeyboardKey.left;
    case 39:
      return KeyboardKey.right;
    case 13:
      return KeyboardKey.enter;
    case 8:
      return KeyboardKey.delete;
    case 16:
      return KeyboardKey.shift;
    case 49:
      return KeyboardKey.one;
    case 50:
      return KeyboardKey.two;
    case 51:
      return KeyboardKey.three;
    case 52:
      return KeyboardKey.four;
    case 53:
      return KeyboardKey.five;
    case 54:
      return KeyboardKey.six;
    case 55:
      return KeyboardKey.seven;
    case 56:
      return KeyboardKey.eight;
    case 57:
      return KeyboardKey.nine;
    case 48:
      return KeyboardKey.zero;
    case 65:
      return KeyboardKey.a;
    case 66:
      return KeyboardKey.b;
    case 67:
      return KeyboardKey.c;
    case 68:
      return KeyboardKey.d;
    case 69:
      return KeyboardKey.e;
    case 70:
      return KeyboardKey.f;
    case 71:
      return KeyboardKey.g;
    case 72:
      return KeyboardKey.h;
    case 73:
      return KeyboardKey.i;
    case 74:
      return KeyboardKey.j;
    case 75:
      return KeyboardKey.k;
    case 76:
      return KeyboardKey.l;
    case 77:
      return KeyboardKey.m;
    case 78:
      return KeyboardKey.n;
    case 79:
      return KeyboardKey.o;
    case 80:
      return KeyboardKey.p;
    case 81:
      return KeyboardKey.q;
    case 82:
      return KeyboardKey.r;
    case 83:
      return KeyboardKey.s;
    case 84:
      return KeyboardKey.t;
    case 85:
      return KeyboardKey.u;
    case 86:
      return KeyboardKey.v;
    case 87:
      return KeyboardKey.w;
    case 88:
      return KeyboardKey.x;
    case 89:
      return KeyboardKey.y;
    case 90:
      return KeyboardKey.z;
    default:
      throw Exception('Unknown key code: $code');
  }
}
