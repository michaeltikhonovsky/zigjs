# ZigJS

ZigJS is a Zig-based wrapper for QuickJS, enabling JavaScript execution within Zig applications.

## Features

- **JavaScript Execution**: Run JavaScript code within your Zig application.
- **console.log Implementation**: JavaScript's `console.log` function is implemented, allowing output from JavaScript to be displayed in your Zig program.

## Example

This project demonstrates how to execute JavaScript code that uses `console.log`:

```zig
const js_code = "console.log('Hello from JavaScript!'); 2 + 2;";
```

When you run the program, it will output:

```
Hello from JavaScript!
Result: 4
```

## Getting Started

Run `zig build run` from the root directory to run it.
Feel free to play around with this code.

## Dependencies

- Zig
- QuickJS
