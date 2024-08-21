# ZigJS

ZigJS is a Zig-based wrapper for QuickJS, enabling JavaScript execution within Zig applications.

## Features

- **JavaScript Execution**: Run JavaScript code within your Zig application.
- **Standard JavaScript Functionality**: QuickJS provides standard JavaScript features like `console.log`, allowing for familiar JavaScript coding patterns.

## Example

This project demonstrates how to execute JavaScript code, including more complex funcitons like Fibonacci:

```zig
const js_code =
    \\function fibonacci(n) {
    \\  if (n<=1) return n;
    \\  return fibonacci(n-1) + fibonacci(n-2);
    \\}
    \\console.log('Fibonacci of 10:', fibonacci(10));
    \\fibonacci(10);
;
```

When you run the program, it will output:

```
Fibonacci of 10: 55
Result: 55
```

## Getting Started

Ensure that you have Zig installed on your system.
Run `zig build run` from the root directory to run it.
Feel free to play around with this code.

## Dependencies

- Zig
- QuickJS
